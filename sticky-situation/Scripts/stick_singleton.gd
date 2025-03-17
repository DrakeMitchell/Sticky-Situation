extends Node

#Stats When laoded into level
var Starting = {
	"Health": 3,
	"SpinDirection":1,
	"StickSpinning": true
}
#Other Variables

var Health = 3;
var ClosestCheckPoint: Area2D;
var CheckPTPosition;
var SpinDirection = 1;
var StickSpinning = true;

#Try to migrate later
var currentLevel = 0;
var globalcurrentLevel = 0;
var totalCoins = 0;
var SaveData

# @export var vcurrentLevelScene = PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveData = SaverLoader.load() as SaveGame
	resetStick() # Replace with function body.

#Allows the HUD and game to keep track of coins and save the number
func addCoin():
	totalCoins += 1
	SaveData.player.totalCoins +=1
	SaveData.levelData[StickSingleton.globalcurrentLevel].updateCollectibles(StickSingleton.currentLevel)
	SaveData.saveGame()
	
	
	#Decrease Health and reset rotation to original 
func HitWall() -> void:
	Health -= 1
	print_debug(Health)
	if(Health <= 0):
		#Die()
		pass
	SpinDirection = Starting["SpinDirection"]
	StickSpinning = Starting["StickSpinning"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func setStick():
	Starting["SpinDirection"] = SpinDirection
	Starting["StickSpinning"] = StickSpinning 

func resetStick():
	Starting["SpinDirection"] = 1;
	Starting["StickSpinning"] = true
	SpinDirection = 1
	StickSpinning = true
	
	#Change Spawn Point when you reach a new checkpoint
func newCheckPoint(checkPoint) -> void:
	setStick()
	#ClosestCheckPoint = checkPoint
	##heckPTPosition = checkPoint.position

func Heal() -> void:
	Health += 1
