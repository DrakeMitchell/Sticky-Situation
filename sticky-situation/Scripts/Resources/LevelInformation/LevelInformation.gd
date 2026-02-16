extends Resource
class_name LevelInformation

#Variables
@export_category("Level Variables")
@export var LevelResource: Level #Level resource
@export var LevelValue: int #Sublevel number 0-2
@export var LevelScene: PackedScene

var StandingOn = false #Touch Detection

@export_category("Level Modifiers")
@export var Challenge: bool
@export var Inverse: bool #flip starting rotation of the stick
@export var Completed: bool
 #Scene to enter
