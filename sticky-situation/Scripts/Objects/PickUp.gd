extends Area2D
class_name Pickup
#Base Class for all Powerup style objects
#Currently Health, Coin, Speed Change

#Variables
@export var type: String
@export var img: Texture2D
@export var speed: bool

var SaveData


#Handles collisions with PickUp Objects
func stickCollision(area) -> void:
	if area.type.contains("coin"):
		if StickSingleton.currentLevel != 100:  # If its a coin and not the challenge level
			Saving.addCoin()
			#SaveData.saveGame() #increase the coin amount and save
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
