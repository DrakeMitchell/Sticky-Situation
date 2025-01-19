extends Area2D

#Variables
@export var Level_Scene: PackedScene #Level Scene to load into
@export var level: int #Sublevel number 0-2
var StandingOn = false #Touch Detection
var saveData: SaveGame #Global Save Game
@export var player: Player #Player object
@export var totalCollectibles: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_LoadData()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#print_debug(saveData.levelData.Collectible)
	if StandingOn == true:
		#print_debug(saveData.getLevelComp())
		if Input.is_action_just_pressed("StartLevel"):
			StickSingleton.currentLevel = level
			Interactions.TOTAL_COLLECTIBLES = totalCollectibles
			get_tree().change_scene_to_packed(Level_Scene)
			#player.getSpawnPoint()
	if saveData.levelData.Collectible[0]:
		$Label.text = "Working"

	#Get Save Data
func _LoadData():
	var gameData = ResourceLoader.load("user://SaveGame.tres") as SaveGame
	if gameData:
		saveData = gameData
	
	#Detect if player is touching
func Node_entered(area: Area2D) -> void:
	_LoadData()
	print_debug("ON")
	StandingOn = true # Replace with function body.

	#Detect if player is no longer touching
func Node_exited(area: Area2D) -> void:
	_LoadData()
	StandingOn = false; # Replace with function body.
