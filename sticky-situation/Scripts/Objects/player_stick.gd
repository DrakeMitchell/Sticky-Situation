extends CharacterBody2D
class_name Player
#Actual Player Character Script handling movement and object collisions


var SaveData
var InWind = false;
var tempSpeed #For changing speed via speed boost
var Dead = false
var inverse = false
var windDir = -1
var tempRotate
var Armor

func _ready() -> void:
	#SaveData = SaverLoader.load()
	inverse = StickSingleton.inverse
	if inverse:
			StickSingleton.SpinDirection = -1

func _physics_process(_delta):
	if get_tree().get_current_scene().name.contains("Gameplay"): #Zoom in Camera for gameplay
		$Camera2D.zoom.x = 2
		$Camera2D.zoom.y = 2
	
	#Change Stick rotation
	if StickSingleton.Health == 0:
		if not StickSingleton.freePlay:
			StickSingleton.resetStick()
			get_tree().change_scene_to_file("res://Scenes/Levels/WorldMap.tscn")
	
	if not Dead:
		if(StickSingleton.StickSpinning == true): 
			rotateStick(StickSingleton.SpinDirection);
	#Movement
		var directionLR = Input.get_axis("Left", "Right")
		if directionLR:
			velocity.x = directionLR * StickSingleton.speed
		else:
			velocity.x = move_toward(velocity.x, 0, StickSingleton.speed)
		var directionUD = Input.get_axis("Up", "Down")
		if directionUD:
			velocity.y = directionUD * StickSingleton.speed
		else:
			velocity.y = directionUD * StickSingleton.speed
		move_and_slide()

		#Speed Up button pressed and released
		if Input.is_action_just_pressed("SpeedUpMove"):
			tempSpeed = StickSingleton.speed
			StickSingleton.speed += 200
		if Input.is_action_just_released("SpeedUpMove"):
			StickSingleton.speed = tempSpeed
			
		#Spin Speed Up Button Pressed and Released
		if Input.is_action_just_pressed("SpeedUpSpin"):
			StickSingleton.SpinDirection *= 2
		if Input.is_action_just_released("SpeedUpSpin"):
			StickSingleton.SpinDirection /= 2
	
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
	print(area)
	if get_tree().get_current_scene().name.contains("WorldMap"):
		pass
	elif get_tree().get_current_scene().name.contains("Menu"):
		pass
	elif area.name.contains("Wall"):
		if not StickSingleton.Armor:
			tempRotate = self.rotation
			Dead = true
			#Some sort of timer
			$"../DeathTimer".start()
		
		# after timer 
		# 
		#Change sprite to broken still
		#Dead = false
	elif area.name.contains("Wind"):
		InWind = true
		windDir = area.direction
			
	elif area.name.contains("armor"):
		print("WORKING")
		StickSingleton.Armor = true
		$"../Armor".start()
	else:
		Interactions.ObjectHit(area) #Send Collision management to Interactions Singleton
		
func Object_Exit(area: Area2D) -> void:
	if area.name.contains("Wind"):
		InWind = false # Replace with function body.
		


func _on_death_timer_timeout() -> void:
	 # Change Sprite back
	#position = Interactions.CheckPTPosition
	StickSingleton.HitWall()
	Dead=false


func _on_armor_timeout() -> void:
	StickSingleton.Armor = false # Replace with function body.
