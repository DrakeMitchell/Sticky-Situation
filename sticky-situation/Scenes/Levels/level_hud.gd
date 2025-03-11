extends CanvasLayer

var SaveData := SaveGame.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveData.loadGame()
 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label2.text = str(StickSingleton.Health)
	$Label4.text = str(SaveData.totalCoins)
