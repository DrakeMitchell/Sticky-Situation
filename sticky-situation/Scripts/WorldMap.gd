extends Node2D
#Code for the worldmap scene
#Escape changes back to Main Menu
#Labels for compeletion of Levels are appropriately set

var SaveData

func _ready() -> void:
	SaveData = SaverLoader.load()
	
	# Create Labels to identify finished levels and load the text here
	$OverworldNode3/Label2.text = str(Saving.playerStats["Levels"]["001"]["Completion"][0])
	$OverworldNode5/Label2.text = str(Saving.playerStats["Levels"]["001"]["Completion"][1])
	$OverworldNode6/Label2.text = str(Saving.playerStats["Levels"]["001"]["Completion"][2])
	
	$OverworldNode7/Label2.text = str(Saving.playerStats["Levels"]["000"]["Completion"][0])
	$OverworldNode8/Label2.text = str(Saving.playerStats["Levels"]["000"]["Completion"][1])
	$OverworldNode9/Label2.text = str(Saving.playerStats["Levels"]["000"]["Completion"][2])
	
	$OverworldNode10/Label2.text = str(Saving.playerStats["Levels"]["002"]["Completion"][0])
	
	#$OverworldNode3/Label.text = str(SaveData.levelData[StickSingleton.globalcurrentLevel].Completed[0]) # Replace with function body.

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Escape"):
		StickSingleton.resetStick()
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
