extends MarginContainer



func _on_upgrade_button_pressed() -> void:
	Global.upgrade_chosen = true
	print(Global.upgrade_chosen)
