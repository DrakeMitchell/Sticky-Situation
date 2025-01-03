extends Node

var Collectible = false;
var Health = 3;
var ClosestCheckPoint: Area2D;
var CheckPTPosition;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func newCheckPoint(checkPoint) -> void:
	ClosestCheckPoint = checkPoint
	CheckPTPosition = checkPoint.position
