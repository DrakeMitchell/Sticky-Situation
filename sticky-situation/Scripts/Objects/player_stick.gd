extends CharacterBody2D
class_name Player

const SPEED = 300
var SaveData := SaveGame.new()
var InWind = false;
var tempSpeed
@export var character: Character

func _ready() -> void:
	StickSingleton.character = character
	var error = SaveData.loadGame()
	if error == null:
		SaveData = SaveGame.new()
	else:
		SaveData = error
	#print(gameData)

func _physics_process(delta):
	if get_tree().get_current_scene().name.contains("Gameplay"):
		$Camera2D.zoom.x = 2
		$Camera2D.zoom.y = 2
	
	#Change Stick rotation
	if(StickSingleton.StickSpinning == true):
		rotateStick(StickSingleton.SpinDirection);
	
	#Movement
	var directionLR = Input.get_axis("Left", "Right")
	if directionLR:
		velocity.x = directionLR * character.Speed
	else:
		velocity.x = move_toward(velocity.x, 0, character.Speed)
	var directionUD = Input.get_axis("Up", "Down")
	if directionUD:
		velocity.y = directionUD * character.Speed
	else:
		velocity.y = directionUD * character.Speed
	move_and_slide()

	if Input.is_action_just_pressed("SpeedUpMove"):
		tempSpeed = character.Speed
		character.Speed += 200
	if Input.is_action_just_released("SpeedUpMove"):
		character.Speed = tempSpeed
		
	if Input.is_action_just_pressed("SpeedUpSpin"):
		print_debug("Pressed")
		StickSingleton.SpinDirection *= 2
	if Input.is_action_just_released("SpeedUpSpin"):
		StickSingleton.SpinDirection /= 2
	
	if InWind:
		position.y -= 1
	#TESTING Saving
	#if Input.is_action_just_pressed("Save"):
		#SaveData.saveGame()
		
	#TESTING Loading
	#if Input.is_action_just_pressed("Load"):
		#SaveData.loadGame()


	#Change Stick Rotation
func rotateStick(dir) -> void:
	self.rotation += 0.02 * dir

	#Detect collisions with overworld nodes
func Object_Hit(area: Area2D) -> void:
	#print_debug(get_tree().get_current_scene().name.contains("WorldMap"))
	if get_tree().get_current_scene().name.contains("WorldMap"):
		pass
	elif get_tree().get_current_scene().name.contains("Menu"):
		pass
	else:
		$"..".ObjectHit(area)

func Object_Exit(area: Area2D) -> void:
	if area.name.contains("Wind"):
		InWind = false # Replace with function body.
		
