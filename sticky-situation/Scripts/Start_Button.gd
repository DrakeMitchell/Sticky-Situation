extends Button

@export var startLevel: PackedScene
var SaveData = SaveGame.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	SaveData.loadGame()
	get_tree().change_scene_to_packed(startLevel) # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	print_debug("Test")
	if Input.is_action_just_pressed("StartLevel"):
		_on_button_down() # Replace with function body.
