extends Node2D
var SaveData := SaveGame.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_load_pressed() -> void:
	SaveData.loadGame()
	print("Saved Coin Amount:",SaveData.totalCoins)# Replace with function body.


func _on_save_pressed() -> void:
	SaveData.totalCoins += 100
	print("Total Coins is now:",SaveData.totalCoins)
	SaveData.saveGame() # Replace with function body.

func _on_clear_pressed() -> void:
	SaveData.totalCoins = 0
	SaveData.levelData[StickSingleton.globalcurrentLevel].Completed[0] = false
	print("New Coin Amount:", SaveData.totalCoins) # Replace with function body.
