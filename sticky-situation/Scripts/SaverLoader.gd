extends Node

var SaveData := SaveGame.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var error = SaveData.loadGame()
	if error == null:
		SaveData = SaveGame.new()
	else:
		SaveData = error # Replace with function body.


func load() -> SaveGame:
	return SaveData
	
func save():
	SaveData.saveGame()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
