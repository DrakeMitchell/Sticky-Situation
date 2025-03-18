extends Resource
class_name Level
#Global Level Resource for each different global level
#Operate by way of "sublevel" in each global level

#All Collectible collected
@export var Collectible: Array[bool] = [false,false,false]
#currently Collected Collectibles, respawn currently
@export var currentCollectibles: Array[int] = [0,0,0]
#total Collectibles
@export var totalCollectibles: Array[int] = [0,0,0]
#Sublevel Completion, cannot detect challenge level completion 
@export var Completed:Array[bool] = [false,false,false]
#Global level designation
@export var globalLevel:int


#Updates the currentCollectibles for sublevel
func updateCollectibles(level):
	if currentCollectibles[level] != totalCollectibles[level]:
		currentCollectibles[level] += 1
	else:
		Collectible[level] = true
		

#Save function
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
		

#load Function
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
