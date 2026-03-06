extends Node
#Almost all interactions run through this singleton


var Collectible = false;
@export var collectibles = 0;
var TOTAL_COLLECTIBLES = 2;
var ClosestCheckPoint: Area2D;
var CheckPTPosition;


#
func newCheckPoint(checkPoint) -> void:
	if StickSingleton.Current["Level"]["Challenge"]:
		StickSingleton.setStick()
	ClosestCheckPoint = checkPoint
	CheckPTPosition = checkPoint.position
	
func ObjectHit(area: Area2D) -> void:
	#Checkpoint Detection
	if area.name.contains("Check"):
		StickSingleton.Current["Health"] = StickSingleton.Starting["Health"]
		StickSingleton.Current["Speed"] = 300
		#newCheckPoint(area)
		
	#Wall Detection

	#Spring Detection
	if area.name.contains("Spring"):
		StickSingleton.Current["SpinDirection"] *= -1
		
	#Finish line detection
	if area.name.contains("Finish"):
		if !StickSingleton.Current["Level"]["Challenge"]:
			Saving.Complete()
		StickSingleton.finished = true

	if area.name.contains("PU"):
		PickUp.stickCollision(area)
		
