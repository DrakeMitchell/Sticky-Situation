extends Resource
class_name SaveGame

#Variables
const SAVE_GAME_PATH = "user://SaveGame.tres"
@export var currentLevel: PackedScene
@export var levelData: Level = preload("res://Scripts/Resources/Level1Resource.tres")

@export var StartPos: Vector2 #For Testing
@export var levelComplete: bool = false #For Testing
	
	#Update Stick Position - Testing
func updatePos(pos) -> void:
	StartPos = pos

	#Update Level Completeion in a specific sublevel - NOT WORKING ATM
func updateLevelComp(boo, level)-> void:
	levelData.updateCompleted(boo, level)
	changed.emit()

	#Save Game function
func saveGame() -> void:
	ResourceSaver.save(self, SAVE_GAME_PATH)
	changed.emit()

	#Load Game Function
func loadGame():
	var gameData = ResourceLoader.load(SAVE_GAME_PATH) as SaveGame
	if gameData:
		StartPos = gameData.StartPos
		levelComplete = gameData.levelComplete
		levelData = gameData.levelData
		print_debug("Level Complete: %s" % levelComplete)
		return gameData
	else:
		print_debug("Failed to load save data.")
		return null
