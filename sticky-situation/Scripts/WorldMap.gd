extends Node2D


var SaveData := SaveGame.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print_debug(get_tree().current_scene.name)
	var error = SaveData.loadGame()
	if error == null:
		SaveData = SaveGame.new()
	else:
		SaveData = error
	$OverworldNode3/Label.text = str(SaveData.levelData.Completed[0]) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Escape"):
		StickSingleton.resetStick()
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
