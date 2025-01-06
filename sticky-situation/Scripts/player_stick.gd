extends CharacterBody2D

class_name Player

const SPEED = 300.0
var SaveData = SaveGame.new()


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

	if Input.is_action_just_pressed("Save"):
		SaveData.updatePos(self.position)
		SaveData.saveGame()
		
	if Input.is_action_just_pressed("Load"):
		SaveData.loadGame()
		self.position = SaveData.StartPos

func rotateStick(dir) -> void:
	self.rotation += 0.02 * dir


func Object_Hit(area: Area2D) -> void:
	#print_debug(get_tree().get_current_scene().name.contains("WorldMap"))
	if get_tree().get_current_scene().name.contains("WorldMap"):
		pass
	else:
		$"..".ObjectHit(area)

	
		
