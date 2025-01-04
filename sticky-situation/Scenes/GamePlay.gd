extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if StickSingleton.StickSpinning == false:
		#for area:Area2D in $"Map Objects".get_children():
			$MapObjects.rotation +=0.01 *StickSingleton.SpinDirection
			#pass
