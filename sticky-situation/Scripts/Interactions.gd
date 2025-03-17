extends Node

var Collectible = false;
@export var collectibles = 0;
var TOTAL_COLLECTIBLES = 2;
var ClosestCheckPoint: Area2D;
var CheckPTPosition;
	
func updateCollected():
	#print_debug(collectibles)
	collectibles += 1;
	if collectibles >= TOTAL_COLLECTIBLES:
		Collectible = true


func newCheckPoint(checkPoint) -> void:
	StickSingleton.setStick()
	ClosestCheckPoint = checkPoint
	CheckPTPosition = checkPoint.position
