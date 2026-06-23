extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_continue_pressed() -> void:
	$PauseMenuLayer.hide()
	$"..".UnPause();


func _on_main_menu_pressed() -> void:
	$PauseMenuLayer.hide()
	$"..".UnPause();
	StickSingleton.finished = false
	get_tree().change_scene_to_file("res://Source/Maps/MainMenu.tscn")
	StickSingleton.Current["Level"]["Attempts"] = 1
	StickSingleton.Current["Health"] = 3 # Replace with function body.


func _on_world_map_button_pressed() -> void:
	$PauseMenuLayer.hide()
	$"..".UnPause();
	StickSingleton.finished = false
	get_tree().change_scene_to_file("res://Source/Maps/WorldMap.tscn")
	StickSingleton.Current["Level"]["Attempts"] = 1
	StickSingleton.Current["Health"] = 3 # Replace with function body.


func _on_option_button_item_selected(index: int) -> void:
	StickSingleton.Starting["Difficulty"] = index
	$"..".setDifficultyMode()
