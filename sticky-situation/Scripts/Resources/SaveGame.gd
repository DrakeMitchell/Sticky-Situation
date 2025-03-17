@tool
extends Resource
class_name SaveGame

#Variables
const SAVE_GAME_PATH := "user://SaveGame.tres"
@export var currentLevel: PackedScene
@export var levelData: Array[Level] = [preload("res://Scripts/Resources/Level1.tres")]
@export var player: Character = preload("res://Scripts/Resources/PlayerCharacter.tres")

var slevel = StickSingleton.currentLevel
var glevel = StickSingleton.globalcurrentLevel
@export var totalCoins: int
	


	#Update Level Completeion in a specific sublevel - NOT WORKING ATM
func updateLevelComp(boolean, sublevel,golevel)-> void:
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
