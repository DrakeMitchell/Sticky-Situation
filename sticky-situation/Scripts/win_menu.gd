extends CanvasLayer
@export var sticks: Array[Texture2D] = []
@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$CanvasLayer/Label3/Label.text = str(StickSingleton.Current["Level"]["Attempts"])
	if StickSingleton.Current["Health"] <= 0:
		$CanvasLayer/Label5/Label.text = str(0)
	else:
		$CanvasLayer/Label5/Label.text = str(StickSingleton.Current["Health"])
	
	if StickSingleton.Current["Health"] == 3:
		$CanvasLayer/Label5/Sprite2D.texture = sticks[0]
	if StickSingleton.Current["Health"] == 2:
		$CanvasLayer/Label5/Sprite2D.texture = sticks[1]
	elif StickSingleton.Current["Health"] == 1:
		$CanvasLayer/Label5/Sprite2D.texture = sticks[2]


func _on_button_pressed() -> void:
	StickSingleton.finished = false
	get_tree().change_scene_to_file("res://Scenes/Levels/WorldMap.tscn")
	StickSingleton.attempts = 1
	StickSingleton.Current["Health"] = 3 # Replace with function body.
