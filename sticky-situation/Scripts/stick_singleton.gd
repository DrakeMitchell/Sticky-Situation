extends Node

#Stats When laoded into level
var Starting = {
	"Health": 3,
	"SpinDirection":1,
	"StickSpinning": true
}

#Other Variables
var Collectible = false;
var Health = 3;
var ClosestCheckPoint: Area2D;
var CheckPTPosition;
var SpinDirection = 1;
var StickSpinning = true;

var currentLevel = 0;

# @export var vcurrentLevelScene = PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Starting["SpinDirection"] = 1;
	Starting["StickSpinning"] = true # Replace with function body.

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
	
	#Change Spawn Point when you reach a new checkpoint
func newCheckPoint(checkPoint) -> void:
	Starting["SpinDirection"] = SpinDirection
	Starting["StickSpinning"] = StickSpinning 
	ClosestCheckPoint = checkPoint
	CheckPTPosition = checkPoint.position
