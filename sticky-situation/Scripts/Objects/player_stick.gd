extends CharacterBody2D
class_name Player

const SPEED = 300.0
var SaveData: SaveGame


func _ready() -> void:
	var gameData = ResourceLoader.load("user://SaveGame.tres") as SaveGame
	if gameData:
		SaveData = gameData

func _physics_process(delta):
	
	#Change Stick rotation
	if(StickSingleton.StickSpinning == true):
		rotateStick(StickSingleton.SpinDirection);
	
	#Movement
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
	else:
		$"..".ObjectHit(area)

	
		
