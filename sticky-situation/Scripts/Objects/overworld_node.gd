extends Area2D
#Base Class for all overworld nodes

#Variables
@export var LevelInfo : LevelInformation

@export var player: Player #Player object


var available



func _process(_delta: float) -> void:
	
	if LevelInfo.StandingOn == true: #If standing on the node
		if Input.is_action_just_pressed("StartLevel"):
			Saving.playerStats["globalLevel"] = LevelInfo.LevelResource.globalLevel
			Saving.playerStats["subLevel"] = LevelInfo.LevelValue
			StickSingleton.Current["Level"]["LevelInformation"] = LevelInfo
			StickSingleton.parseLevelInfo()
			StickSingleton.invert()
			if get_tree().current_scene.name.contains("Map"):
				Saving.playerStats["savedPos"][0] = player.position.x
				Saving.playerStats["savedPos"][1] = player.position.y
			if self.name.contains("FreePlay"):
				StickSingleton.freePlay = true
			if self.name.contains("Demo"):
				StickSingleton.freePlay = false
			
			if !LevelInfo.Challenge: #If not challenge level
				Interactions.TOTAL_COLLECTIBLES = LevelInfo.LevelResource.totalCollectibles[LevelInfo.LevelValue] #Set current total collectibles
			else:
				StickSingleton.challenge 
				Interactions.TOTAL_COLLECTIBLES = 5 
			StickSingleton.resetStick()
			
			
			if available:
				get_tree().change_scene_to_packed(LevelInfo.LevelScene)
	
#Detect if player is touching
func Node_entered(_area: Area2D) -> void:
	if StickSingleton.freePlay != true:
		detectProgress()
	else:
		available = true
	LevelInfo.StandingOn = true # Replace with function body.

#Detect if player is no longer touching
func Node_exited(_area: Area2D) -> void:
	LevelInfo.StandingOn = false; # Replace with function body.
	
func detectProgress():
	var global = LevelInfo.LevelResource.globalLevel

	if global == 0:
		available = true
	elif Saving.checkCompletion(global-1):
		available = true
		
	if LevelInfo.LevelValue != 0:
		if Saving.checkCompletion(global,LevelInfo.LevelValue-1):
			available = true
		else:
			available = false
			
	if LevelInfo.LevelValue == 100:
		available = false

		
		
	
