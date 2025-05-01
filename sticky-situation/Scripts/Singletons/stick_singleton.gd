extends Node
#Singleton Code for everything that has to do with the player
#Working on migrating some variables to better positions
signal Death
#Stats When laoded into level
var Starting = {
	"Health": 3,
	"SpinDirection":1,
	"StickSpinning": true
}
#Other Variables
var Health = 3; #Current Health
var ClosestCheckPoint: Area2D; #
var CheckPTPosition;
var SpinDirection = 1;
var StickSpinning = true;
var inverse = false;
var speed = 300
var Armor = false
var savedPos = Vector2(-1105,-147)
#Try to migrate later
var currentLevel = 0
var globalcurrentLevel = 0;
var totalCoins = 0;
var freePlay = false
var challenge = false
var finished
var attempts = 1

func _ready() -> void:
	resetStick() 

#Allows the HUD and game to keep track of coins and save the number
func addCoin():
	totalCoins += 1
	
	
#Decrease Health and reset rotation to original 
func HitWall() -> void:
	Health -= 1
	#print_debug(Health)
	if(Health <= 0):
		Die()
	#SpinDirection = Starting["SpinDirection"]
	#StickSpinning = Starting["StickSpinning"]

#Set new spin directions for each checkpoint
func setStick():
	Starting["SpinDirection"] = SpinDirection
	Starting["StickSpinning"] = StickSpinning 

	
func invert():
	if inverse:
		SpinDirection = -1
		Starting["SpinDirection"] = -1
		#print(inverse, " INVERTING ________________")
	else:
		SpinDirection = 1
		Starting["SpinDirection"] = 1
#Reset to default values, ie leaving the level and reentering 
func resetStick():
	#Starting["SpinDirection"] = 1;
	#Starting["StickSpinning"] = true
	SpinDirection = Starting["SpinDirection"]
	#StickSpinning = true
	Health = Starting["Health"]

#Heal the player
func Heal() -> void:
	if Health < Starting["Health"]:
		Health += 1
		
func Die():
	attempts += 1
