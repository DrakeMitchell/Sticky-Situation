extends Resource
class_name Level

#Collectible and Level completion check for each of the 3 sub levels
@export var Collectible: Array[bool] = [false,false,false]
@export var currentCollectibles: Array[int] = [0,0,0]
@export var totalCollectibles: Array[int] = [0,0,0]
@export var Completed:Array[bool] = [false,false,false]
@export var globalLevel:int


#@export var Level_Scene: PackedScene #Level Scene to load into
func updateCollectibles(level):
	if currentCollectibles[level] != totalCollectibles[level]:
		currentCollectibles[level] += 1
	else:
		Collectible[level] = true
		

func save() -> void:
	var data:= Level.new()
	data.Completed = Completed
	data.Collectible = Collectible
	data.currentCollectibles = currentCollectibles
	data.totalCollectibles = totalCollectibles
	data.globalLevel = globalLevel
	
	var error := ResourceSaver.save(data,self.resource_path)
	if error:
		print("An error happened while saving data: ", error)
		
		
func loadGame():
	var gameData = load(self.resource_path) as Level
	if gameData:
		Completed = gameData.Completed
		currentCollectibles = gameData.currentCollectibles
		Collectible = gameData.Collectible
		totalCollectibles = gameData.totalCollectibles
		globalLevel = gameData.globalLevel

		return gameData
	else:
		print_debug("Failed to load save data.")
		return null
