extends Area2D
class_name Pickup

@export var type: String
@export var img: Texture2D
@export var speed: bool
@export var character: Character
var SaveData := SaveGame.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveData = SaverLoader.load()# Replace with function body.s


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print_debug(type)
	pass

func stickCollision(area) -> void:
	print_debug(area.type)
	if area.type.contains("coin"):
		
		if StickSingleton.currentLevel != 100:
			print("HELLLLLLO")
			SaveData.levelData[StickSingleton.globalcurrentLevel].updateCollectibles(StickSingleton.currentLevel)
	if area.type.contains("speed"):
		if area.speed == true:
			StickSingleton.character.Speed = 500
		else:
			StickSingleton.character.Speed = 150
	if(area.type.contains("health")):
		StickSingleton.Heal()
	if(area.type.contains("shield")):
		pass
	area.queue_free()
