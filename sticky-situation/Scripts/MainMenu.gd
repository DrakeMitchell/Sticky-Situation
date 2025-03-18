extends Node2D
var SaveData
#Code for Main Menu Scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveData = SaverLoader.load()


func _on_load_pressed() -> void:
	SaveData.loadGame()

func _on_save_pressed() -> void:
	SaveData.saveGame() 

func _on_clear_pressed() -> void:
	#Should make a clear function in SaveData
	
	SaveData.player.totalCoins = 0
	SaveData.levelData[StickSingleton.globalcurrentLevel].Completed[0] = false
	SaveData.saveGame() # Replace with function body.
