extends Node2D

#Variables
var levelStarts: Array[Area2D] = []
@export var LevelResource: Level #Unique Level per map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print_debug(get_tree().current_scene.name)
	
	#Change player location to correct sublevel first checkpoint
	if(get_tree().current_scene.name.contains("1")):
		levelStarts.append(get_node("MapObjects/CheckPoint"))
		levelStarts.append(get_node("MapObjects2/CheckPointStart2"))
		$Player.position = detectSpawnPoint().global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#Change Stick Rotation
	if StickSingleton.StickSpinning == false:
		$MapObjects.rotation +=0.01 *StickSingleton.SpinDirection
			#pass

#Choose a spawn point
func detectSpawnPoint() -> Area2D:
	var spawnPoint = levelStarts[StickSingleton.currentLevel];
	#print_debug(spawnPoint.position)
	return spawnPoint

#Stick Collsion detection and computing
#Should probably be it's on script honestly
func ObjectHit(area: Area2D) -> void:
	#Checkpoint Detection
	if area.name.contains("Check"):
		StickSingleton.newCheckPoint(area)
	#Wall Detection
	if area.name.contains("Wall"):
		StickSingleton.HitWall()
		$Player.position = StickSingleton.CheckPTPosition
	#Spring Detection
	if area.name.contains("Spring"):
		#StickSingleton.StickSpinning = false;
		StickSingleton.SpinDirection *= -1
	#Finish line detection
	if area.name.contains("Finish"):
		LevelResource.updateCompleted(true,StickSingleton.currentLevel)
