extends Node

var Collectible = false;
@export var collectibles = 0;
var TOTAL_COLLECTIBLES = 2;
var ClosestCheckPoint: Area2D;
var CheckPTPosition;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func updateCollected():
	print_debug(collectibles)
	collectibles += 1;
	if collectibles >= TOTAL_COLLECTIBLES:
		Collectible = true
	print_debug(Collectible)


func newCheckPoint(checkPoint) -> void:
	StickSingleton.setStick()
	ClosestCheckPoint = checkPoint
	CheckPTPosition = checkPoint.position
