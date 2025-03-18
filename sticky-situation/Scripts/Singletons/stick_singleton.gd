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
var Health = 3; #Current Health
var ClosestCheckPoint: Area2D; #
var CheckPTPosition;
var SpinDirection = 1;
var StickSpinning = true;

#Try to migrate later
var currentLevel = 0;
var globalcurrentLevel = 0;
var totalCoins = 0;
var SaveData

func _ready() -> void:
	SaveData = SaverLoader.load() as SaveGame
	resetStick() 

#Allows the HUD and game to keep track of coins and save the number
func addCoin():
	totalCoins += 1
	SaveData.player.totalCoins +=1
	SaveData.levelData[StickSingleton.globalcurrentLevel].updateCollectibles(StickSingleton.currentLevel)
	SaveData.saveGame()
	
#Decrease Health and reset rotation to original 
func HitWall() -> void:
	Health -= 1
	#print_debug(Health)
	if(Health <= 0):
		Die()
	SpinDirection = Starting["SpinDirection"]
	StickSpinning = Starting["StickSpinning"]

#Set new spin directions for each checkpoint
func setStick():
	Starting["SpinDirection"] = SpinDirection
	Starting["StickSpinning"] = StickSpinning 

#Reset to default values, ie leaving the level and reentering 
func resetStick():
	Starting["SpinDirection"] = 1;
	Starting["StickSpinning"] = true
	SpinDirection = 1
	StickSpinning = true
	Health = Starting["Health"]

#Heal the player
func Heal() -> void:
	if Health < Starting["Health"]:
		Health += 1
		
func Die():
	pass
