extends Area2D

@export var Level_Scene: PackedScene
@export var level: int
@export var Resourc: Resource
var StandingOn = false
@export var saveData = SaveGame.new()

@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if StandingOn == true:
		#print_debug(saveData.getLevelComp())
		if Input.is_action_just_pressed("StartLevel"):
			StickSingleton.currentLevel = level
			get_tree().change_scene_to_packed(Level_Scene)
			#player.getSpawnPoint()
		if saveData.getLevelComp() == true:
			$Label.text = "Working"


func Node_entered(area: Area2D) -> void:
	StandingOn = true # Replace with function body.


func Node_exited(area: Area2D) -> void:
	StandingOn = false; # Replace with function body.
