extends Node
##Singleton Code for everything that has to do with the player
#Working on migrating some variables to better positions

#--Public Variables--
##Default starting stats When loaded into level
var Starting = {
	"Health": 3,
	"SpinDirection":1,
	"StickSpinning": true
}

##Current updated stats
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
}
#TODO: Try to migrate later
var totalCoins = 0;
var freePlay = false
var finished;

#--Public Functions--
func parseLevelInfo(info:LevelInformation) -> void:
	if info != null:
		Current["Level"]["LevelInformation"] = info
		Current["Level"]["Inverse"] = Current["Level"]["LevelInformation"].Inverse
		Current["Level"]["CurrentSubLevel"] = Current["Level"]["LevelInformation"].LevelValue
		Current["Level"]["Challenge"] = Current["Level"]["LevelInformation"].Challenge
		invert()

##Increases the amount of coins by 1
func addCoin() -> void:
	totalCoins += 1

##Decrease Health by 1, if 0 then Die() 
func HitWall() -> void:
	Current["Health"] -= 1
	if(Current["Health"] <= 0):
		Die()

##Save current spin directions for each checkpoint
func setStick():
	Starting["SpinDirection"] = Current["SpinDirection"]
	Starting["StickSpinning"] = Current["StickSpinning"] 

##Invert the stick spinning direction
func invert():
	if Current["Level"]["Inverse"]:
		Current["SpinDirection"] = -1
		Starting["SpinDirection"] = -1
	else:
		Current["SpinDirection"] = 1
		Starting["SpinDirection"] = 1

##Reset to default values, ie leaving the level and reentering 
func resetStick():
	Current["SpinDirection"] = Starting["SpinDirection"]
	Current["Health"] = Starting["Health"]

##Heal the player to full health
func Heal() -> void:
	if Current["Health"] < Starting["Health"]:
		Current["Health"] += 1

##Increase the amount of Current attempts by 1
func Die():
	Current["Level"]["Attempts"] += 1

#--Private Functions--
func _ready() -> void:
	resetStick() 
