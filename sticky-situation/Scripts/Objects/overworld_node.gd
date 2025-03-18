extends Area2D
#Base Class for all overworld nodes

#Variables
@export var LevelResource: Level #Level resource
@export var level: int #Sublevel number 0-2
var StandingOn = false #Touch Detection

@export var player: Player #Player object
@export var Inverse: bool #Not used
@export var LevelScene: PackedScene #Scene to enter

var SaveData 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveData = SaverLoader.load()

func _process(_delta: float) -> void:
	
	if StandingOn == true: #If standing on the node
		if Input.is_action_just_pressed("StartLevel"):
			StickSingleton.currentLevel = level #Sublevel set
			if StickSingleton.currentLevel != 100: #If not challenge level
				Interactions.TOTAL_COLLECTIBLES = LevelResource.totalCollectibles[level] #Set current total collectibles
			else:
				#Isn't global at all, wont work with more levels
				Interactions.TOTAL_COLLECTIBLES = 5 
			StickSingleton.resetStick()
			
			get_tree().change_scene_to_packed(LevelScene)
	
#Detect if player is touching
func Node_entered(_area: Area2D) -> void:
	StandingOn = true # Replace with function body.

#Detect if player is no longer touching
func Node_exited(_area: Area2D) -> void:
	StandingOn = false; # Replace with function body.
