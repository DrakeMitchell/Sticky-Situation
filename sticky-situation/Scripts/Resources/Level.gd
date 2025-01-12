extends Resource
class_name Level

#Collectible and Level completion check for each of the 3 sub levels
@export var Collectible: Array[bool] = [false,false,false]
@export var Completed:Array[bool] = [false,false,false]


#Change the collectible check of each sub level
func updateCollectible(boo, level):
	Collectible[level] = boo
	
#Change the level completion check of each sub level
func updateCompleted(boo, level):
	Completed[level] = boo
