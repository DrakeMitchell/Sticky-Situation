@tool
extends Resource
class_name SaveGame

#Variables
const SAVE_GAME_PATH := "user://SaveGame.tres"
@export var currentLevel: PackedScene
@export var levelData: Array[Level] = [preload("res://Scripts/Resources/Level1.tres")]

@export var StartPos: Vector2 #For Testing
@export var levelComplete: bool = false #For Testing

@export var totalCoins: int = 0
	
	#Update Stick Position - Testing
func updatePos(pos) -> void:
	StartPos = pos

	#Update Level Completeion in a specific sublevel - NOT WORKING ATM
func updateLevelComp(boolean, sublevel,golevel)-> void:
	levelData[golevel].Completed[sublevel] = true

	#Save Game function
func saveGame() -> void:
	var data:= SaveGame.new()
	data.StartPos = StartPos
	data.totalCoins = totalCoins
	#data.levelData = levelData
	levelData[StickSingleton.globalcurrentLevel].save()
	
	var error := ResourceSaver.save(data, SAVE_GAME_PATH)
	if error:
		print("An error happened while saving data: ", error)
	#changed.emit()

	#Load Game Function
func loadGame():
	var gameData = load(SAVE_GAME_PATH)
	if gameData:
		StartPos = gameData.StartPos
		#levelComplete = gameData.levelComplete
		totalCoins = gameData.totalCoins
		#levelData = gameData.levelData
		
		levelData[StickSingleton.globalcurrentLevel].loadGame()
		
		print_debug("Level Complete: %s" % levelComplete)
		return gameData
	else:
		print_debug("Failed to load save data.")
		return null
