extends Node2D
#Code for Main Menu Scene

func _on_load_pressed() -> void:
	Saving.load_json_file()
	pass

func _on_save_pressed() -> void:
	Saving.write_to_json_file() 
	pass

func _on_clear_pressed() -> void:
	Saving.clear_data()
	Saving.load_json_file()
