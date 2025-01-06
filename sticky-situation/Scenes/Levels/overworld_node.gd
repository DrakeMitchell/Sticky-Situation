extends Area2D

@export var Level_Scene: PackedScene
var StandingOn = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("StartLevel"):
		get_tree().change_scene_to_packed(Level_Scene)


func Node_entered(area: Area2D) -> void:
	StandingOn = true # Replace with function body.
