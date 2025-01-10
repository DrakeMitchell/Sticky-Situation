extends Node2D

var levelStarts: Array[Area2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug(get_tree().current_scene.name)
	if(get_tree().current_scene.name.contains("1")):
		levelStarts.append(get_node("MapObjects/CheckPoint"))
		levelStarts.append(get_node("MapObjects2/CheckPointStart2"))
		$Player.position = detectSpawnPoint().global_position
	
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if StickSingleton.StickSpinning == false:
		$MapObjects.rotation +=0.01 *StickSingleton.SpinDirection
			#pass

func detectSpawnPoint() -> Area2D:
	var spawnPoint = levelStarts[StickSingleton.currentLevel];
	print_debug(spawnPoint.position)
	return spawnPoint

func ObjectHit(area: Area2D) -> void:
	if area.name.contains("Check"):
		StickSingleton.newCheckPoint(area)
		pass
	if area.name.contains("Wall"):
		StickSingleton.HitWall()
		$Player.position = StickSingleton.CheckPTPosition
	if area.name.contains("Spring"):
		#StickSingleton.StickSpinning = false;
		StickSingleton.SpinDirection *= -1
