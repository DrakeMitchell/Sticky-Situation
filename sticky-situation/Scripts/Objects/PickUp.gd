extends Area2D
class_name Pickup

@export var type: String
@export var img: Texture2D
@export var speed: bool

var SaveData
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveData = SaverLoader.load()# Replace with function body.s


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print_debug(type)
	pass

#Handles collisions with PickUp Objects
func stickCollision(area) -> void:
	if area.type.contains("coin"):
		if StickSingleton.currentLevel != 100:  # If its a coin and not the challenge level
			StickSingleton.addCoin()
			SaveData.saveGame() #increase the coin amount and save
	if area.type.contains("speed"):
		if area.speed == true: #If it its a speed change
			StickSingleton.character.Speed = 500 #Increase
		else:
			StickSingleton.character.Speed = 150 #Decrease
	if(area.type.contains("health")):
		StickSingleton.Heal() #If it is a heal
	if(area.type.contains("shield")):
		pass
	area.queue_free()
