extends Node
#Singleton Code for everything that has to do with the player
#Working on migrating some variables to better positions
#Stats When laoded into level
var Starting = {
	"Health": 3,
	"SpinDirection":1,
	"StickSpinning": true
}

#Other Variables
var Current ={
	"Health" : 3,#Current Health
	"SpinDirection" : 1,
	"StickSpinning" : true,
	"Speed" : 300,
	"Armor" : false,
	"Level":{
		"LevelInformation" : LevelInformation,
		"Inverse" : false,
		"CurrentSubLevel" : -1,
		"Challenge" : false,
		"TotalCoins" : 0,
		"Attempts": 1
	}
	
	#"SavedPos" : Vector2(-1105,-147)
}
#Try to migrate later
var totalCoins = 0;
var freePlay = false
var finished;

func _ready() -> void:
	resetStick() 


func parseLevelInfo():
	if Current["Level"]["LevelInformation"] != null:
		Current["Level"]["Inverse"] = Current["Level"]["LevelInformation"].Inverse
		Current["Level"]["CurrentSubLevel"] = Current["Level"]["LevelInformation"].LevelValue
		Current["Level"]["Challenge"] = Current["Level"]["LevelInformation"].Challenge
		
		
	

#Allows the HUD and game to keep track of coins and save the number
func addCoin():
	totalCoins += 1
	
	
#Decrease Health and reset rotation to original 
func HitWall() -> void:
	Current["Health"] -= 1
	if(Current["Health"] <= 0):
		Die()

#Set new spin directions for each checkpoint
func setStick():
	Starting["SpinDirection"] = Current["SpinDirection"]
	Starting["StickSpinning"] = Current["StickSpinning"] 

func invert():
	if Current["Level"]["Inverse"]:
		Current["SpinDirection"] = -1
		Starting["SpinDirection"] = -1
	else:
		Current["SpinDirection"] = 1
		Starting["SpinDirection"] = 1
		
#Reset to default values, ie leaving the level and reentering 
func resetStick():
	Current["SpinDirection"] = Starting["SpinDirection"]
	Current["Health"] = Starting["Health"]

#Heal the player
func Heal() -> void:
	if Current["Health"] < Starting["Health"]:
		Current["Health"] += 1
		
func Die():
	Current["Level"]["Attempts"] += 1
