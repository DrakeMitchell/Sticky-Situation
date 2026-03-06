extends Node2D
##Global Script for all gameplay Scenes


#--Exported Variables--
@export var LevelResource: Level #Unique Level per map

#--Onready Variables--
@onready var LevelsNode: Node = $Levels 

#--Public Variables--
var levelStarts: Array[Area2D] = []


#--Private Functions--
func _ready() -> void:
	getLevelStarts()

func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("Escape"):
		get_tree().change_scene_to_file("res://Source/Maps/WorldMap.tscn")
		StickSingleton.finished = false
		StickSingleton.Current["Level"]["Attempts"] = 1
		StickSingleton.Current["Health"] = 3
	#Change Stick Rotation
	#if StickSingleton.Current["StickSpinning"] == false:
		#$MapObjects.rotation +=0.01 *StickSingleton.Current["SpinDirection"]
		
	if StickSingleton.Current["Health"] == 0:
		if not StickSingleton.freePlay:
			if StickSingleton.Current["Level"]["Inverse"]:
				StickSingleton.Starting["SpinDirection"] = -1
				StickSingleton.Current["SpinDirection"] = -1
			else:
				StickSingleton.Starting["SpinDirection"] = 1
				StickSingleton.Current["SpinDirection"] = 1
				StickSingleton.resetStick()
			
			$Player.position = detectSpawnPoint().global_position
	if StickSingleton.finished:
		$HUD/WinMenu.get_child(0).show()

#--Public Functions
##Get all first checkpoints from any amount of levels and append them to levelStarts
func getLevelStarts() -> void:
	var LevelsNum = LevelsNode.get_child_count()
	
	if LevelsNum == 0: return
	
	for i in range(LevelsNum):
		var level:Area2D = LevelsNode.get_child(i).getCheckpoint()
		levelStarts.append(level)
	
	$Player.position = detectSpawnPoint().global_position


##Chooses the correct spawn point based on the sublevel
##Moves Finish Lines if it is Challenge Mode
##[return] The Correct Spawn Point according to sublevel
func detectSpawnPoint() -> Area2D:
	var spawnPoint = levelStarts[0];
	if !StickSingleton.Current["Level"]["Challenge"]:
		spawnPoint = levelStarts[StickSingleton.Current["Level"]["CurrentSubLevel"]];
	else:
		$Levels/Level01/Interactions/FinishLine.global_position.x = -3000
		$Levels/Level02/Interactions/FinishLine.global_position.x = -3000
	
	return spawnPoint
