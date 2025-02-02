extends Area2D
class_name Pickup

@export var type: String
@export var img: Texture2D
@export var speed: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print_debug(type)
	pass

func stickCollision(area) -> void:
	print_debug(area.type)
	if area.type.contains("coin"):
		Interactions.updateCollected()
		area.queue_free()
	if area.type.contains("speed"):
		if area.speed == true:
			StickSingleton.moveSpeed = 500
		else:
			StickSingleton.moveSpeed = 150
		area.queue_free()
	if(area.type.contains("health")):
		StickSingleton.Heal()
	if(area.type.contains("shield")):
		pass
		
