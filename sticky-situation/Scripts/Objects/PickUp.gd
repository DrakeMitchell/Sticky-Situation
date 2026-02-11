extends Area2D
class_name Pickup
#Base Class for all Powerup style objects
#Currently Health, Coin, Speed Change

#Variables
@export var type: String
@export var img: Texture2D
@export var speed: bool



#Handles collisions with PickUp Objects
func stickCollision(area) -> void:
	if area.type.contains("coin"):
		if !StickSingleton.Current["Level"]["Challenge"]:  # If its a coin and not the challenge level
			Saving.addCoin()

	if area.type.contains("speed"):
		if area.speed == true: #If it its a speed change
			StickSingleton.Current["Speed"] = 500 #Increase
		else:
			StickSingleton.speed = 150 #Decrease
	if(area.type.contains("health")):
		StickSingleton.Heal() #If it is a heal
	if(area.type.contains("shield")):
		StickSingleton.Current["Armor"] = true
		#var timer = get_node("/root/Armor")
		#timer.start()
	area.queue_free()
