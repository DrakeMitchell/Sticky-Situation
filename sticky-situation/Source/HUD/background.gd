extends CanvasLayer
##Handles the background images

#--Exported Variables--
@export var front: Texture2D
@export var middle: Texture2D
@export var back: Texture2D


func _ready() -> void:
	$ParallaxBackground/Front/Sprite2D.texture = front
	$ParallaxBackground/Middle/Sprite2D.texture = middle
	$ParallaxBackground/Back/Sprite2D2.texture = back # Replace with function body.
