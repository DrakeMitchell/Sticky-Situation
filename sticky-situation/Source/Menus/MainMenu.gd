extends Node2D
#Code for Main Menu Scene

# Called when the node enters the scene tree for the first time.


func _on_load_pressed() -> void:
	#SaveData.loadGame()
	#Saving._ready()
	Saving.load_json_file()
	#print(Saving.checkCompletion(1))
	pass

func _on_save_pressed() -> void:
	#SaveData.saveGame()
	Saving.write_to_json_file() 
	pass

func _on_clear_pressed() -> void:
	Saving.clear_data()
	Saving.load_json_file()
	#Should make a clear function in SaveData
	#
	#SaveData.player.totalCoins = 0
	#SaveData.levelData[StickSingleton.globalcurrentLevel].Completed[0] = false
	#SaveData.saveGame() # Replace with function body.
