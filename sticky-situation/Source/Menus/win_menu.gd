extends CanvasLayer
@export var sticks: Array[Texture2D] = []
@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$"WinMenuLayer/Labels/Total Attempts/Total Attempts Num".text = str(StickSingleton.Current["Level"]["Attempts"])
	if StickSingleton.Current["Health"] <= 0:
		$"WinMenuLayer/Labels/Current Health/Current Health Num".text = str(0)
	else:
		$"WinMenuLayer/Labels/Current Health/Current Health Num".text = str(StickSingleton.Current["Health"])
	
	if StickSingleton.Current["Health"] == 3:
		$"WinMenuLayer/Labels/Current Health/Stick Damage".texture = sticks[0]
	if StickSingleton.Current["Health"] == 2:
		$"WinMenuLayer/Labels/Current Health/Stick Damage".texture = sticks[1]
	elif StickSingleton.Current["Health"] == 1:
		$"WinMenuLayer/Labels/Current Health/Stick Damage".texture = sticks[2]


func _on_button_pressed() -> void:
	StickSingleton.finished = false
	get_tree().change_scene_to_file("res://Source/Maps/WorldMap.tscn")
	StickSingleton.Current["Level"]["Attempts"] = 1
	StickSingleton.Current["Health"] = 3 # Replace with function body.
