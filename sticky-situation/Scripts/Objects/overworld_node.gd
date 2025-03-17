extends Area2D

#Variables
@export var LevelResource: Level #Level resource
@export var level: int #Sublevel number 0-2
var StandingOn = false #Touch Detection

@export var player: Player #Player object
@export var Inverse: bool #Not used
@export var LevelScene: PackedScene

var SaveData 

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
				#Isn't global at all, wont work with more levels
				Interactions.TOTAL_COLLECTIBLES = 5 
			StickSingleton.resetStick()
			
			get_tree().change_scene_to_packed(LevelScene)
	
	#Detect if player is touching
func Node_entered(area: Area2D) -> void:
	StandingOn = true # Replace with function body.

	#Detect if player is no longer touching
func Node_exited(area: Area2D) -> void:
	StandingOn = false; # Replace with function body.
