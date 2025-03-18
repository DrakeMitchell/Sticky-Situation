@tool
extends Resource
class_name SaveGame

#Holds Vital Save Data for the game, need to migrate to json to work for exporting


#Variables
const SAVE_GAME_PATH := "user://SaveGame.tres" #Saved Address of SaveGame data
@export var levelData: Array[Level] = [preload("res://Scripts/Resources/Level1.tres")] #Array of the game level resources
@export var player: Character = preload("res://Scripts/Resources/PlayerCharacter.tres") #The Character resource

var slevel = StickSingleton.currentLevel  #current Sublevel
var glevel = StickSingleton.globalcurrentLevel #current Global Level
@export var totalCoins: int #Total Amount of Coins, Should be stored in Character
	


#Update Level Completeion in a specific sublevel 
func updateLevelComp(sublevel,golevel)-> void:
	levelData[golevel].Completed[sublevel] = true
	

#Adds a coin to the global level resource
func addCoin() -> void:
	levelData[slevel].updateCollectibles(slevel)

	#Save Game function
func saveGame() -> void:
	var data:= SaveGame.new()
	data.totalCoins = totalCoins

	levelData[StickSingleton.globalcurrentLevel].save()
	player.saveGame()
	print("Saved coins as ", data.totalCoins)
	
	var error := ResourceSaver.save(data, SAVE_GAME_PATH)
	if error:
		print("An error happened while saving data: ", error)
	#changed.emit()

	#Load Game Function
func loadGame():
	var gameData = load(SAVE_GAME_PATH)
	if gameData:
		totalCoins = gameData.totalCoins
		levelData[StickSingleton.globalcurrentLevel].loadGame()
		player.loadGame()
		return gameData
	else:
		print_debug("Failed to load save data.")
		return null
