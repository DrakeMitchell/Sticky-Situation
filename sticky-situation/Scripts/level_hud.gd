extends CanvasLayer

var SaveData
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveData = SaverLoader.load()
 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	textChange()
	
	
func textChange():
	SaveData.loadGame()
	$Label2.text = str(StickSingleton.Health)
	$Label4.text = str(StickSingleton.totalCoins)
