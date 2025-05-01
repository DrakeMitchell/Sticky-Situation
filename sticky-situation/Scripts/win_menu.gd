extends CanvasLayer
@export var sticks: Array[Texture2D] = []
@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/Label3/Label.text = str(StickSingleton.attempts)
	if StickSingleton.Health <= 0:
		$CanvasLayer/Label5/Label.text = str(0)
	else:
		$CanvasLayer/Label5/Label.text = str(StickSingleton.Health)
	
	if StickSingleton.Health == 3:
		$CanvasLayer/Label5/Sprite2D.texture = sticks[0]
	if StickSingleton.Health == 2:
		$CanvasLayer/Label5/Sprite2D.texture = sticks[1]
	elif StickSingleton.Health == 1:
		$CanvasLayer/Label5/Sprite2D.texture = sticks[2]


func _on_button_pressed() -> void:
	StickSingleton.finished = false
	get_tree().change_scene_to_file("res://Scenes/Levels/WorldMap.tscn")
	StickSingleton.attempts = 1
	StickSingleton.Health = 3 # Replace with function body.


#func _on_button_2_pressed() -> void:
	#visible = false
	#if StickSingleton.inverse:
		#StickSingleton.Starting["SpinDirection"] = -1
		#StickSingleton.SpinDirection = -1
		##print("WELLL WHAT THE FUCK IS IT THEN", StickSingleton.Starting["SpinDirection"])
	#else:
		#StickSingleton.Starting["SpinDirection"] = 1
		#StickSingleton.SpinDirection = 1
		#StickSingleton.resetStick()
	#
	#player.position = Interactions.CheckPTPosition
	
		 # Replace with function body.
