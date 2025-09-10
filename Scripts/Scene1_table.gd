extends Node2D

const PIXEL = preload("res://Scenes/pixel.tscn")

@onready var marker: CharacterBody2D = $Marker
@onready var draw_point: Marker2D = $Marker/DrawPoint

var pause_menu_scene = preload("res://Scenes/pause_menu.tscn")
var pause_menu_instance = null

func _process(delta: float) -> void:
	if marker.drawing:
		var pixel = PIXEL.instantiate()
		add_child(pixel)
		if Global.ink > 0:
			Global.ink -= Global.INK_COST
		pixel.position = marker.position
	elif Global.ink < 100:
		Global.ink += Global.INK_REGEN
		
func _input(event):
	if event.is_action_pressed("pause"):
		if pause_menu_instance == null:
			_show_pause_menu()
		else:
			_hide_pause_menu()

func _show_pause_menu():
	pause_menu_instance = pause_menu_scene.instantiate()
	add_child(pause_menu_instance)
	get_tree().paused = true

func _hide_pause_menu():
	get_tree().paused = false
	if pause_menu_instance != null:
		pause_menu_instance.queue_free()
		pause_menu_instance = null
