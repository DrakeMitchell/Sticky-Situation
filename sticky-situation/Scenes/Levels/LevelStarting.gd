extends Node
class_name levelSpawning

var levelStarts: Array[Node2D] = [$"../MapObjects/CheckPoint",$"../MapObjects/CheckPoint2"]

var spawnPoint: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug(levelStarts[1])
	
func detectSpawnPoint() -> Node2D:
	spawnPoint = levelStarts[StickSingleton.currentLevel];
	return spawnPoint
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
