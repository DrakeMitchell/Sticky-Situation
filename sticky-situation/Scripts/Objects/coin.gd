extends Pickup


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("Working")

	type = "coin"
	print_debug(type)
	#stickCollision(self)
