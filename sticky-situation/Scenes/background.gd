extends CanvasLayer

@export var front: Texture2D
@export var middle: Texture2D
@export var back: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ParallaxBackground/Front/Sprite2D.texture = front
	$ParallaxBackground/Middle/Sprite2D.texture = middle
	$ParallaxBackground/Back/Sprite2D.texture = back # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
