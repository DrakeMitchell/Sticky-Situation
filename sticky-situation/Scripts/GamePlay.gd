extends Node2D
#Global Script for all gameplay Scenes

#Variables
var levelStarts: Array[Area2D] = []
@export var LevelResource: Level #Unique Level per map
@export var ChallengeMode = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if(StickSingleton.currentLevel == 101):
		ChallengeMode = true;
	
	
	
	#Change player location to correct sublevel first checkpoint
	#Gotta be a better way of doing this
	
	levelStarts.append(get_node("Map1/CheckPoint"))
	levelStarts.append(get_node("Map2/CheckPoint"))
	levelStarts.append(get_node("Map3/CheckPoint"))
		
	if ChallengeMode:
		$Player.position = challengeMode().global_position
		
	else:
		$Player.position = detectSpawnPoint().global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("Escape"):
		get_tree().change_scene_to_file("res://Scenes/Levels/WorldMap.tscn")
		StickSingleton.finished = false
		StickSingleton.attempts = 1
		StickSingleton.Health = 3
	#Change Stick Rotation
	if StickSingleton.StickSpinning == false:
		$MapObjects.rotation +=0.01 *StickSingleton.SpinDirection
		
	if StickSingleton.Health == 0:
		if not StickSingleton.freePlay:
			if StickSingleton.inverse:
				StickSingleton.Starting["SpinDirection"] = -1
				StickSingleton.SpinDirection = -1
				#print("WELLL WHAT THE FUCK IS IT THEN", StickSingleton.Starting["SpinDirection"])
			else:
				StickSingleton.Starting["SpinDirection"] = 1
				StickSingleton.SpinDirection = 1
				StickSingleton.resetStick()
			
			$Player.position = detectSpawnPoint().global_position
			#pass
	if StickSingleton.finished:
		#$WinMenu.enable()
		$WinMenu.get_child(0).show()
		#HUD name .show and .enable
		#Buttons connect to worldmap and reset .finished


#Choose a spawn point
func detectSpawnPoint() -> Area2D:
	var spawnPoint = levelStarts[StickSingleton.currentLevel];
	return spawnPoint


func challengeMode() -> Area2D:
	var spawnPoint = levelStarts[0];
	$Map1/FinishLine.global_position.x = -3000
	$Map2/FinishLine.global_position.x = -3000
	$Dividers.global_position.x = -3000
	return spawnPoint;
 # Replace with function body.
