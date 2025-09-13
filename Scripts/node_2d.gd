extends Node2D

const PIXEL = preload("res://Scenes/pixel.tscn")
const INK_COST = .4
const INK_REGEN = .3
@onready var marker: CharacterBody2D = $Marker
@onready var draw_point: Marker2D = $Marker/DrawPoint

func _process(delta: float) -> void:
	if marker.drawing:
		var pixel = PIXEL.instantiate()
		print("drawn")
		add_child(pixel)
		if Global.ink > 0:
			Global.ink -= INK_COST
		pixel.position = marker.position
	elif Global.ink < 100:
		Global.ink += INK_REGEN
