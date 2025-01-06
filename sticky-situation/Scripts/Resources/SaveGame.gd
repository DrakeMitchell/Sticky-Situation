extends Resource
class_name SaveGame

const SAVE_GAME_PATH = "user://SaveGame.tres"
@export var currentLevel: PackedScene

@export var StartPos: Vector2

	
func _ready() -> void:
	pass
	

func updatePos(pos) -> void:
	StartPos = pos

func saveGame() -> void:
	ResourceSaver.save(self, SAVE_GAME_PATH)
	print_debug(StartPos)
	
func loadGame() -> Resource:
	print_debug(StartPos)
	StartPos = ResourceLoader.load(SAVE_GAME_PATH).StartPos
	return ResourceLoader.load(SAVE_GAME_PATH).duplicate(true)
