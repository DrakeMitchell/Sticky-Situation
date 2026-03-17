extends Area2D
##Base Class for all overworld nodes

#--Exported Variables--
@export var LevelInfo : LevelInformation
@export var player: Player #Player object

#--Public Variables--
var canEnterArea

#--Private Functions--
func _process(_delta: float) -> void:
	enterArea(LevelInfo.StandingOn) #If standing on the node
		
	
#--Public Functions--
##Check if you are standing on a node, Enter the level and set positions and information accordingly 
func enterArea(StandingOn: bool) -> void:
	if StandingOn:
		if Input.is_action_just_pressed("StartLevel"):
				Saving.playerStats["globalLevel"] = LevelInfo.LevelResource.globalLevel
				Saving.playerStats["subLevel"] = LevelInfo.LevelValue
				StickSingleton.parseLevelInfo(LevelInfo)
				
				if get_tree().current_scene.name.contains("Map"):
					Saving.playerStats["savedPos"][0] = player.position.x
					Saving.playerStats["savedPos"][1] = player.position.y
					
				if self.name.contains("FreePlay"):
					StickSingleton.freePlay = true
				if self.name.contains("Demo"):
					StickSingleton.freePlay = false
					
				StickSingleton.resetStick()

				if canEnterArea:
					get_tree().change_scene_to_packed(LevelInfo.LevelScene)

##Detect Level Progression to determine if a player can enter a level
func detectProgress():
	var global = LevelInfo.LevelResource.globalLevel

	if global == 0:
		canEnterArea = true
	elif Saving.checkCompletion(global-1):
		canEnterArea = true

	if LevelInfo.LevelValue != 0:
		if Saving.checkCompletion(global,LevelInfo.LevelValue-1):
			canEnterArea = true
		else:
			canEnterArea = false

	if LevelInfo.LevelValue == 100:
		canEnterArea = false

#Detect if player is touching the node, determine whether or not they can enter the level
func Node_entered(_area: Area2D) -> void:
	if StickSingleton.freePlay != true:
		detectProgress()
	else:
		canEnterArea = true
	LevelInfo.StandingOn = true

#Detect if player is no longer touching the node
func Node_exited(_area: Area2D) -> void:
	LevelInfo.StandingOn = false;
