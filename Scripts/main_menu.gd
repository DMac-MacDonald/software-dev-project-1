extends Control
@onready var start_button: Button = $ButtonContainers/StartButton
@onready var options_button: Button = $ButtonContainers/OptionsButton
@onready var quit_button: Button = $ButtonContainers/QuitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.grab_focus()
	
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Scene1_table.tscn")

func _on_options_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()
