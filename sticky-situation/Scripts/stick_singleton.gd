extends Node

#Stats When laoded into level
var Starting = {
	"Health": 3,
	"SpinDirection":1,
	"StickSpinning": true
}

var character: Character
var moveSpeed = 300
#Other Variables

var Health = 3;
var ClosestCheckPoint: Area2D;
var CheckPTPosition;
var SpinDirection = 1;
var StickSpinning = true;

var currentLevel = 0;

# @export var vcurrentLevelScene = PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resetStick() # Replace with function body.

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
