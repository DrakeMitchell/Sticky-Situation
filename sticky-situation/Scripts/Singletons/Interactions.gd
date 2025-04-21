extends Node
#Almost all interactions run through this singleton


var Collectible = false;
@export var collectibles = 0;
var TOTAL_COLLECTIBLES = 2;
var ClosestCheckPoint: Area2D;
var CheckPTPosition;
var SaveData

func _ready() -> void:
	#SaveData = SaverLoader.load()
	pass
	
#func updateCollected():
	##print_debug(collectibles)
	#collectibles += 1;
	#if collectibles >= TOTAL_COLLECTIBLES:
		#Collectible = true


func newCheckPoint(checkPoint) -> void:
	if StickSingleton.challenge:
		StickSingleton.setStick()
	ClosestCheckPoint = checkPoint
	CheckPTPosition = checkPoint.position
	
func ObjectHit(area: Area2D) -> void:
	#Checkpoint Detection
	if area.name.contains("Check"):
		Interactions.newCheckPoint(area)
		StickSingleton.Health = StickSingleton.Starting["Health"]
		StickSingleton.speed = 300
		
	#Wall Detection

	#Spring Detection
	if area.name.contains("Spring"):
		#StickSingleton.StickSpinning = false;
		StickSingleton.SpinDirection *= -1
	#Finish line detection
	if area.name.contains("Finish"):
		if StickSingleton.currentLevel != 101:
			#SaveData.updateLevelComp(StickSingleton.currentLevel,StickSingleton.globalcurrentLevel)
			Saving.Complete()
		#SaveData.totalCoins = StickSingleton.totalCoins
		#print_debug("Coins Collected: %s:" % Interactions.TOTAL_COLLECTIBLES)
		#print_debug("All Coins Collected: %s" % Interactions.Collectible)
		StickSingleton.resetStick()
		#print_debug(StickSingleton.SpinDirection = 1)
		get_tree().change_scene_to_file("res://Scenes/Levels/WorldMap.tscn")
	if area.name.contains("PU"):
		PickUp.stickCollision(area)
		
