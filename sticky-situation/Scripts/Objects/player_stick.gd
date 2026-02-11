extends CharacterBody2D
class_name Player
#Actual Player Character Script handling movement and object collisions

var InWind = false;
var tempSpeed #For changing speed via speed boost
var Dead = false
var inverse = false
var windDir = -1
var tempRotate
var Armor
var tempSpinning
@export var sticks: Array[Texture2D] = []


func _ready() -> void:
	#SaveData = SaverLoader.load()
	if StickSingleton.Current["Level"]["Inverse"]:
		StickSingleton.Starting["SpinDirection"] = -1
		StickSingleton.Current["SpinDirection"] = -1
		StickSingleton.setStick()

func _physics_process(_delta):
	if get_tree().get_current_scene().name.contains("Gameplay"): #Zoom in Camera for gameplay
		$Camera2D.zoom.x = 2
		$Camera2D.zoom.y = 2
	
	StickImage()
	
	#Change Stick rotation
	if StickSingleton.Current["Health"] == 0 and not StickSingleton.finished:
		#if not StickSingleton.freePlay:
		if StickSingleton.Current["Level"]["Inverse"]:
			StickSingleton.Starting["SpinDirection"] = -1
			StickSingleton.Current["SpinDirection"] = -1
			
			#StickSingleton.resetStick()
			
	if not Dead:
		if(StickSingleton.Current["StickSpinning"] == true): 
			rotateStick(StickSingleton.Current["SpinDirection"]);
	#Movement
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

		#Speed Up button pressed and released
		if Input.is_action_just_pressed("SpeedUpMove"):
			tempSpeed = StickSingleton.Current["Speed"]
			StickSingleton.Current["Speed"] += 200
		if Input.is_action_just_released("SpeedUpMove"):
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
			
		if StickSingleton.finished:
			remove_child($Area2D)
			remove_child($Sprite2D)
		
	else:
		self.rotation = rotation



#Change Stick Rotation, dir = 1 or -1
func rotateStick(dir) -> void:
	self.rotation += 0.02 * dir

#Detect collisions with overworld nodes
func Object_Hit(area: Area2D) -> void:
	#print(area)
	if get_tree().get_current_scene().name.contains("WorldMap"):
		pass
	elif get_tree().get_current_scene().name.contains("Menu"):
		pass
	elif area.name.contains("Wall"):
		if not StickSingleton.Current["Armor"]:
			tempRotate = self.rotation
			Dead = true
			#Some sort of timer
			$"../DeathTimer".start()
		
		# after timer 
		# 
		#Change sprite to broken stick
		#Dead = false
	elif area.name.contains("Wind"):
		InWind = true
		windDir = area.direction
			
	elif area.name.contains("armor"):
		#print("WORKING")
		StickSingleton.Current["Armor"] = true
		$"../Armor".start()
	else:
		Interactions.ObjectHit(area) #Send Collision management to Interactions Singleton
		
func Object_Exit(area: Area2D) -> void:
	if area.name.contains("Wind"):
		InWind = false # Replace with function body.
		
func StickImage():
	var Health = StickSingleton.Current["Health"]
	if Health > 0:
		$Sprite2D.texture = sticks[Health-3]
	else:
		$Sprite2D.texture = sticks[1]
		

func _on_death_timer_timeout() -> void:
	 # Change Sprite back
	StickSingleton.HitWall()
	Dead=false


func _on_armor_timeout() -> void:
	StickSingleton.Current["Armor"] = false # Replace with function body.
	
