extends Area2D
#Base Class for all overworld nodes

#Variables
@export var LevelResource: Level #Level resource
@export var level: int #Sublevel number 0-2
var StandingOn = false #Touch Detection

@export var player: Player #Player object
@export var Inverse: bool #flip starting rotation of the stick
@export var LevelScene: PackedScene #Scene to enter

var SaveData 
var available

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	
	if StandingOn == true: #If standing on the node
		if Input.is_action_just_pressed("StartLevel"):
			Saving.playerStats["globalLevel"] = LevelResource.globalLevel
			Saving.playerStats["subLevel"] = level
			StickSingleton.currentLevel = level
			StickSingleton.inverse = Inverse
			StickSingleton.invert()
			if get_tree().current_scene.name.contains("Map"):
				Saving.playerStats["savedPos"][0] = player.position.x
				Saving.playerStats["savedPos"][1] = player.position.y
			if self.name.contains("FreePlay"):
				StickSingleton.freePlay = true
			if self.name.contains("Demo"):
				StickSingleton.freePlay = false
			
			if level != 101: #If not challenge level
				Interactions.TOTAL_COLLECTIBLES = LevelResource.totalCollectibles[level] #Set current total collectibles
			else:
				#Isn't global at all, wont work with more levels
				StickSingleton.challenge
				Interactions.TOTAL_COLLECTIBLES = 5 
			StickSingleton.resetStick()
			
			
			if available:
				get_tree().change_scene_to_packed(LevelScene)
	
#Detect if player is touching
func Node_entered(area: Area2D) -> void:
	if StickSingleton.freePlay != true:
		detectProgress()
		print("Working")
	else:
		available = true
	print(StickSingleton.freePlay)
	StandingOn = true # Replace with function body.

#Detect if player is no longer touching
func Node_exited(_area: Area2D) -> void:
	StandingOn = false; # Replace with function body.
	
func detectProgress():
	var global = LevelResource.globalLevel

	if global == 0:
		available = true
	elif Saving.checkCompletion(global-1):
		available = true
	if level != 0:
		if Saving.checkCompletion(global,level-1):
			available = true
		else:
			available = false
	if level == 100:
		available = false

		
		
	
