extends Node2D

const PIXEL = preload("res://Scenes/pixel.tscn")

@onready var marker: CharacterBody2D = $Marker
@onready var draw_point: Marker2D = $Marker/DrawPoint

func _process(delta: float) -> void:
	if marker.drawing:
		var pixel = PIXEL.instantiate()
		add_child(pixel)
		if Global.ink > 0:
			Global.ink -= Global.INK_COST
		pixel.position = marker.position
	
	
