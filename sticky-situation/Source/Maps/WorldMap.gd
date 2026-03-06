extends Node2D
##Code for the worldmap scene
##Escape changes back to Main Menu
##Labels for compeletion of Levels are appropriately set

#--Onready Variables--
@onready var LevelOneCompletion: Node = $"Completion/Level-1"
@onready var LevelZeroCompletion: Node = $"Completion/Level-0"
@onready var LevelTwoCompletion: Node = $"Completion/Level-2"

#--Private Functions--
func _ready() -> void:
	#print(Saving.playerStats["savedPos"][0])
	$Player.position.x = int(Saving.playerStats["savedPos"][0])
	$Player.position.y = int(Saving.playerStats["savedPos"][1])

	setCompletionLabels()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Escape"):
		StickSingleton.resetStick()
		get_tree().change_scene_to_file("res://Source/Maps/MainMenu.tscn")

##Loop through the level completion labels and update to the saved data
func setCompletionLabels()-> void:
	for i in range(LevelZeroCompletion.get_child_count()):
		var tempLabel:Label = LevelZeroCompletion.get_child(i)
		tempLabel.text = str(Saving.playerStats["Levels"]["000"]["Completion"][i])
	
	for i in range(LevelOneCompletion.get_child_count()):
		var tempLabel:Label = LevelOneCompletion.get_child(i)
		tempLabel.text = str(Saving.playerStats["Levels"]["001"]["Completion"][i])
		
	for i in range(LevelTwoCompletion.get_child_count()):
		var tempLabel:Label = LevelTwoCompletion.get_child(i)
		tempLabel.text = str(Saving.playerStats["Levels"]["002"]["Completion"][i])
