extends Area2D

#Variables
@export var LevelResource: Level
@export var level: int #Sublevel number 0-2
var StandingOn = false #Touch Detection
#var saveData: SaveGame #Global Save Game
@export var player: Player #Player object
@export var Inverse: bool
@export var LevelScene: PackedScene
var SaveData := SaveGame.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveData = SaverLoader.load()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#print_debug(saveData.levelData.Collectible)
	if StandingOn == true:
		#print_debug(saveData.getLevelComp())
		if Input.is_action_just_pressed("StartLevel"):
			StickSingleton.currentLevel = level
			
			if StickSingleton.currentLevel != 100:
				Interactions.TOTAL_COLLECTIBLES = LevelResource.totalCollectibles[level]
			else:
				Interactions.TOTAL_COLLECTIBLES = 5
			StickSingleton.resetStick()
			
			get_tree().change_scene_to_packed(LevelScene)
			#get_tree().unload_current_scene()
			#player.getSpawnPoint()
#	if saveData.levelData.Collectible[0]:
	#	$Label.text = "Working"

	#Get Save Data
	#if gameData:
		#saveData = gameData
	
	#Detect if player is touching
func Node_entered(area: Area2D) -> void:
	#_LoadData()
	#print_debug("ON")
	StandingOn = true # Replace with function body.

	#Detect if player is no longer touching
func Node_exited(area: Area2D) -> void:
	#_LoadData()
	StandingOn = false; # Replace with function body.
