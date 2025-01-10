extends Resource
class_name SaveGame

const SAVE_GAME_PATH = "user://SaveGame.tres"
@export var currentLevel: PackedScene

@export var StartPos: Vector2

@export var levelComplete: bool = false
	
func _ready() -> void:
	pass
	

func updatePos(pos) -> void:
	StartPos = pos

func updateLevelComp(boo)-> void:
	levelComplete = boo
	print_debug(levelComplete)
	
func getLevelComp() -> bool:
	return levelComplete	

func saveGame() -> void:
	ResourceSaver.save(self, SAVE_GAME_PATH)
	print_debug(StartPos)
	changed.emit()
	
func loadGame() -> Resource:
	print_debug(levelComplete)
	StartPos = ResourceLoader.load(SAVE_GAME_PATH).StartPos
	levelComplete = ResourceLoader.load(SAVE_GAME_PATH).levelComplete
	return ResourceLoader.load(SAVE_GAME_PATH).duplicate(true)
