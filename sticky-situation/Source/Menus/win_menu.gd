extends CanvasLayer
##Sets up and controls the Win Screen Menu

#--Exported Variables--
@export var sticks: Array[Texture2D] = []
@export var player: Player

#--Private Functions
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	setWinMenuLabels()

func _on_button_pressed() -> void:
	StickSingleton.finished = false
	get_tree().change_scene_to_file("res://Source/Maps/WorldMap.tscn")
	StickSingleton.Current["Level"]["Attempts"] = 1
	StickSingleton.Current["Health"] = 3
	StickSingleton.Current["GamePaused"] = false # Replace with function body.
	
#--Public Functions
##Runs in process, sets up the correct labels and images for the win screen
func setWinMenuLabels()->void:
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
		
func setPlayer(p:Player):
	player = p
