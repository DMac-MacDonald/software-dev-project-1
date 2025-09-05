extends CanvasLayer
@onready var options_container: PanelContainer = $OptionsContainer/MenusContainer/OptionsContainer

const AUDIO = preload("res://Scenes/audio_settings.tscn")
func _on_audio_settings_pressed() -> void:
	if options_container.get_child_count() == 0:
		var audio_settings = AUDIO.instantiate()
		options_container.add_child(audio_settings)
	else:
		for n in options_container.get_children():
			options_container.remove_child(n)
			n.queue_free()

func _on_video_settings_pressed() -> void:
	if options_container.get_child_count() == 0:
		pass
	else:
		for n in options_container.get_children():
			options_container.remove_child(n)
			n.queue_free()

func _on_accessibility_settings_pressed() -> void:
	if options_container.get_child_count() == 0:
		pass
	else:
		for n in options_container.get_children():
			options_container.remove_child(n)
			n.queue_free()

func _on_return_button_pressed() -> void:
	queue_free()
