extends Node2D

#Variables
var levelStarts: Array[Area2D] = []
@export var LevelResource: Level #Unique Level per map
@export var ChallengeMode = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print_debug(get_tree().current_scene.name)
	if(StickSingleton.currentLevel == 100):
		ChallengeMode = true;
	
	
	
	#Change player location to correct sublevel first checkpoint
	if(get_tree().current_scene.name.contains("1")):
		levelStarts.append(get_node("MapObjects/CheckPoint"))
		levelStarts.append(get_node("MapObjects2/CheckPointStart2"))
		
	if(get_tree().current_scene.name.contains("Caverns")):
		levelStarts.append(get_node("Map1/CheckPoint"))
		levelStarts.append(get_node("Map2/CheckPoint"))
		levelStarts.append(get_node("Map3/CheckPoint"))
		
		
	if ChallengeMode:
		$Player.position = challengeMode().global_position
		
	else:
		$Player.position = detectSpawnPoint().global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Escape"):
		get_tree().change_scene_to_file("res://Scenes/Levels/WorldMap.tscn")
	#Change Stick Rotation
	if StickSingleton.StickSpinning == false:
		$MapObjects.rotation +=0.01 *StickSingleton.SpinDirection
			#pass

#Choose a spawn point
func detectSpawnPoint() -> Area2D:
	var spawnPoint = levelStarts[StickSingleton.currentLevel];
	#print_debug(spawnPoint.position)
	return spawnPoint


func challengeMode() -> Area2D:
	var spawnPoint = levelStarts[0];
	$Map1/FinishLine.global_position.x = -3000
	$Map2/FinishLine.global_position.x = -3000
	$Dividers.global_position.x = -3000
	return spawnPoint;


#Stick Collsion detection and computing
#Should probably be it's on script honestly
func ObjectHit(area: Area2D) -> void:
	#Checkpoint Detection
	if area.name.contains("Check"):
		Interactions.newCheckPoint(area)
	#Wall Detection
	if area.name.contains("Wall"):
		StickSingleton.HitWall()
		$Player.position = Interactions.CheckPTPosition
	#Spring Detection
	if area.name.contains("Spring"):
		#StickSingleton.StickSpinning = false;
		StickSingleton.SpinDirection *= -1
	#Finish line detection
	if area.name.contains("Wind"):
		$Player.InWind = true
	if area.name.contains("Finish"):
		#LevelResource.updateCompleted(true,StickSingleton.currentLevel)
		print_debug("Coins Collected: %s:" % Interactions.collectibles)
		print_debug("All Coins Collected: %s" % Interactions.Collectible)
		get_tree().change_scene_to_file("res://Scenes/Levels/WorldMap.tscn")
	if area.name.contains("Coin"):
		Interactions.updateCollected()
		area.queue_free()
