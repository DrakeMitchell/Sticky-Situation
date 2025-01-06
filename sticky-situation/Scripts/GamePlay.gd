extends Node2D

var current_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if StickSingleton.StickSpinning == false:
		$MapObjects.rotation +=0.01 *StickSingleton.SpinDirection
			#pass

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
