extends Area2D
class_name Pickup
#Base Class for all Powerup style objects
#Currently Health, Coin, Speed Change

#Variables
@export var Interaction: Interactable;
@export var type: String
@export var img: Texture2D
@export var speed: bool

#"Checkpoint:0","Coin:1", "Health:2", "SpeedIncrease:3", "SpeedDecrease:4"


#Handles collisions with PickUp Objects
func stickCollision(area: Pickup) -> void:
	if area.type.contains("coin") or area.Interaction.PickupType == 1:
		if !StickSingleton.Current["Level"]["Challenge"]:  # If its a coin and not the challenge level
			Saving.addCoin()

	if area.type.contains("speed"):
		if area.speed == true: #If it its a speed change
			StickSingleton.Current["Speed"] = 500 #Increase
		else:
			StickSingleton.speed = 150 #Decrease
			
	if area.Interaction.PickupType == 3:
		StickSingleton.Current["Speed"] = 500
	elif area.Interaction.PickupType == 4:
		StickSingleton.speed = 150 #Decrease
	
	if(area.type.contains("health") or area.Interaction.PickupType == 2):
		StickSingleton.Heal() #If it is a heal
	if(area.type.contains("shield") or area.Interaction.GameplayEffect == 2):
		StickSingleton.Current["Armor"] = true
		#var timer = get_node("/root/Armor")
		#timer.start()
	area.queue_free()
