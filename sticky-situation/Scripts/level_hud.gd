extends CanvasLayer
#Level Hud Code
#Updates Values based on StickSingleton


var SaveData

func _ready() -> void:
	SaveData = SaverLoader.load()




func _process(_delta: float) -> void:
	textChange()
	
	
func textChange():
	SaveData.loadGame()
	$Label2.text = str(StickSingleton.Health)
	$Label4.text = str(Saving.playerStats["totalCoins"])
