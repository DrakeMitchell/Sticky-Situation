extends Node

#Exists to make loading the save file easier in other files

var SaveData := SaveGame.new()

func _ready() -> void:
	var error = SaveData.loadGame()
	if error == null:
		SaveData = SaveGame.new()
	else:
		SaveData = error # Replace with function body.

func load() -> SaveGame:
	return SaveData
	
func save():
	SaveData.saveGame()
