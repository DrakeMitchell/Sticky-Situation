extends Resource
class_name LevelInformation

#Variables
@export var LevelResource: Level #Level resource
@export var LevelValue: int #Sublevel number 0-2

var StandingOn = false #Touch Detection

@export var Challenge: bool
@export var Inverse: bool #flip starting rotation of the stick

@export var Completed: bool
@export var LevelScene: PackedScene #Scene to enter
