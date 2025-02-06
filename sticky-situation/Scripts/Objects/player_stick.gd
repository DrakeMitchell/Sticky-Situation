extends CharacterBody2D
class_name Player

const SPEED = 300
var SaveData: SaveGame
var InWind = false;

func _ready() -> void:
	var gameData = ResourceLoader.load("user://SaveGame.tres") as SaveGame
	if gameData:
		SaveData = gameData

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
		velocity.x = directionLR * StickSingleton.moveSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, StickSingleton.moveSpeed)
	var directionUD = Input.get_axis("Up", "Down")
	if directionUD:
		velocity.y = directionUD * StickSingleton.moveSpeed
	else:
		velocity.y = directionUD * StickSingleton.moveSpeed
	move_and_slide()

	if Input.is_action_just_pressed("SpeedUpMove"):
		StickSingleton.moveSpeed = 500
	if Input.is_action_just_released("SpeedUpMove"):
		StickSingleton.moveSpeed = 300
		
	if Input.is_action_just_pressed("SpeedUpSpin"):
		print_debug("Pressed")
		StickSingleton.SpinDirection *= 2
	if Input.is_action_just_released("SpeedUpSpin"):
		StickSingleton.SpinDirection /= 2
	
	if InWind:
		position.y -= 1
	#TESTING Saving
	if Input.is_action_just_pressed("Save"):
		SaveData.updatePos(self.position)
		SaveData.updateLevelComp(true,0)
		SaveData.saveGame()
		
	#TESTING Loading
	if Input.is_action_just_pressed("Load"):
		SaveData.loadGame()
		self.position = SaveData.StartPos

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
