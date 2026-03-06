extends CanvasLayer
##Level Hud Code
##Updates Values based on StickSingleton

func _process(_delta: float) -> void:
	textChange()
	
##Update Health and Coin Num text based on player stats
func textChange():
	if StickSingleton.Current["Health"] <= 0:
		$"Lives Num".text = str(0)
	else:
		$"Lives Num".text = str(StickSingleton.Current["Health"])
	$"Coins Num".text = str(Saving.playerStats["totalCoins"])
