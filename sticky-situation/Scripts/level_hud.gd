extends CanvasLayer
#Level Hud Code
#Updates Values based on StickSingleton

func _process(_delta: float) -> void:
	textChange()
	
	
func textChange():
	if StickSingleton.Health <= 0:
		$Label2.text = str(0)
	else:
		$Label2.text = str(StickSingleton.Health)
	$Label4.text = str(Saving.playerStats["totalCoins"])
