extends CharacterBody2D

class_name Player

const SPEED = 300.0


func _physics_process(delta):
	
	if(StickSingleton.StickSpinning == true):
		rotateStick(StickSingleton.SpinDirection);
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionLR = Input.get_axis("Left", "Right")
	if directionLR:
		velocity.x = directionLR * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var directionUD = Input.get_axis("Up", "Down")
	if directionUD:
		velocity.y = directionUD * SPEED
	else:
		velocity.y = directionUD * SPEED

	move_and_slide()

	

func rotateStick(dir) -> void:
	self.rotation += 0.02 * dir


func Object_Hit(area: Area2D) -> void:
	if area.name.contains("Check"):
		StickSingleton.newCheckPoint(area)
		pass
	if area.name.contains("Wall"):
		StickSingleton.HitWall()
		position = StickSingleton.CheckPTPosition
	if area.name.contains("Spring"):
		#StickSingleton.StickSpinning = false;
		StickSingleton.SpinDirection *= -1
	
		
