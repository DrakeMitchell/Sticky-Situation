extends Node2D
#Code for Main Menu Scene

func _on_load_pressed() -> void:
	Saving.load_all()
	pass

func _on_save_pressed() -> void:
	Saving.write_all()
	pass

func _on_clear_pressed() -> void:
	Saving.clear_data()
	#Saving.load_and_write_all()
