extends CharacterBody2D
class_name Player
#Actual Player Character Script handling movement and object collisions

var InWind:bool = false;
var Dead:bool = false
var inverse:bool = false
var windDir = -1
var Armor
var tempSpeed:int
var tempSpinning:bool
var difficultyMode
@export var sticks: Array[Texture2D] = []


func _ready() -> void:
	setStick()
	setCameraZoom(2)
	UnPause()
	setDifficultyMode()

func _process(_float) -> void:
	handlePauseAction()
	
	
func handlePauseAction():
	if Input.is_action_just_pressed("Escape"):
		if !StickSingleton.Current["GamePaused"]:
			Pause();
		else:
			UnPause()
			
func Pause():
		#Unhide Pause menu
		$PauseMenu.get_child(0).show()
		StickSingleton.Current["StickSpinning"] = false
		StickSingleton.Current["Speed"] = 0
		StickSingleton.Current["GamePaused"] = true
			
func UnPause():
		$PauseMenu.get_child(0).hide()
		StickSingleton.Current["StickSpinning"] = true
		StickSingleton.Current["Speed"] = 300
		StickSingleton.Current["GamePaused"] = false
	
func setDifficultyMode():
	difficultyMode = Saving.playerSettings["Difficulty"];
	if difficultyMode == 0:
		self.scale.y = 0.5
	elif difficultyMode == 1:
		self.scale.y = 0.75
	elif difficultyMode == 2:
		self.scale.y = 1.0
	else:
		self.scale.y = 1.25
	
		


func setStick()->void:
	if StickSingleton.Current["Level"]["Inverse"]:
		StickSingleton.Starting["SpinDirection"] = -1
		StickSingleton.Current["SpinDirection"] = -1
		StickSingleton.setStick()
		
func setCameraZoom(Zoom:float)->void:
	if get_tree().get_current_scene().name.contains("Gameplay"): #Zoom in Camera for gameplay
		$GameCamera.zoom.x = Zoom
		$GameCamera.zoom.y = Zoom

func setStartingStickRotation()->void:
	if StickSingleton.Current["Health"] == 0 and not StickSingleton.finished:
		if StickSingleton.Current["Level"]["Inverse"]:
			StickSingleton.Starting["SpinDirection"] = -1
			StickSingleton.Current["SpinDirection"] = -1
			
func handlePlayerMovement()->void:
	var directionLR = Input.get_axis("Left", "Right")
	if directionLR:
		velocity.x = directionLR * StickSingleton.Current["Speed"]
	else:
		velocity.x = move_toward(velocity.x, 0, StickSingleton.Current["Speed"])
	var directionUD = Input.get_axis("Up", "Down")
	if directionUD:
		velocity.y = directionUD * StickSingleton.Current["Speed"]
	else:
		velocity.y = directionUD * StickSingleton.Current["Speed"]
	move_and_slide()


func _physics_process(_delta):

	
	StickImage()
	setStartingStickRotation()
	
	#Change Stick rotation
	if not Dead:
		if(StickSingleton.Current["StickSpinning"] == true): 
			rotateStick(StickSingleton.Current["SpinDirection"]);
	#Movement
		handlePlayerMovement()
		#TODO Figure out how to move the Speed Up and Down into a seperate Function
		
		#Speed Up button pressed and released
		if Input.is_action_just_pressed("SpeedUpMove"):
			if !StickSingleton.Current["GamePaused"]:
				print(StickSingleton.Current["Speed"])
				tempSpeed = StickSingleton.Current["Speed"]
				StickSingleton.Current["Speed"] += 200
		if Input.is_action_just_released("SpeedUpMove"):
			if !StickSingleton.Current["GamePaused"]:
				if tempSpeed:
					StickSingleton.Current["Speed"] = tempSpeed
		
		#Spin Speed Up Button Pressed and Released
		if Input.is_action_just_pressed("SpeedUpSpin"):
			tempSpinning = true
			StickSingleton.Current["SpinDirection"] *= 2
		if Input.is_action_just_released("SpeedUpSpin"):
			if tempSpinning:
				StickSingleton.Current["SpinDirection"] /= 2
		
	#In the wind object
		if InWind:
			position += windDir
		
	else:
		self.rotation = rotation

#Change Stick Rotation, dir = 1 or -1
func rotateStick(dir) -> void:
	self.rotation += 0.02 * dir

#Detect collisions with overworld nodes
func Object_Hit(area: Area2D) -> void:
	var _tempRotate:float
	if get_tree().get_current_scene().name.contains("WorldMap"):
		pass
	elif get_tree().get_current_scene().name.contains("Menu"):
		pass
	elif area.name.contains("Wall"):
		if not StickSingleton.Current["Armor"]:
			_tempRotate = self.rotation
			Dead = true
			#Some sort of timer
			$"../Timers/DeathTimer".start()
		
	elif area.name.contains("Wind"):
		InWind = true
		windDir = area.direction
			
	elif area.name.contains("armor"):
		#print("WORKING")
		StickSingleton.Current["Armor"] = true
		$"../Timers/Armor".start()
	else:
		Interactions.ObjectHit(area) #Send Collision management to Interactions Singleton
		
func Object_Exit(area: Area2D) -> void:
	if area.name.contains("Wind"):
		InWind = false # Replace with function body.
		
func StickImage():
	if StickSingleton.Current["Health"] > 0:
		$StickImage.texture = sticks[StickSingleton.Current["Health"]-3]
	else:
		$StickImage.texture = sticks[1]
		

func _on_death_timer_timeout() -> void:
	 # Change Sprite back
	StickSingleton.HitWall()
	Dead=false


func _on_armor_timeout() -> void:
	StickSingleton.Current["Armor"] = false # Replace with function body.
	
