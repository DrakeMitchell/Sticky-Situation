extends Resource
class_name Character

@export var Speed = 300
@export var totalCoins = 0


func saveGame() -> void:
	var data:= Character.new()
	data.Speed = Speed
	data.totalCoins = totalCoins
	print("Saved coins as ", data.totalCoins)
	
	var error := ResourceSaver.save(data, self.resource_path)
	if error:
		print("An error happened while saving data: ", error)
#Not Used ATM

func loadGame():
	var gameData = load(self.resource_path) as Character
	if gameData:
		totalCoins = gameData.totalCoins
		StickSingleton.totalCoins = totalCoins
		Speed = gameData.Speed

		return gameData
	else:
		print_debug("Failed to load save data.")
		return null
