extends MarginContainer

@onready var upgrade_description: Label = $PanelContainer/VBoxContainer/UpgradeDescription

var descriptions = []
var rng = RandomNumberGenerator.new()
func _ready() -> void:
	load_descriptions()
	var random = rng.randf_range(0, descriptions.size())
	upgrade_description.text = descriptions[random]
func _on_upgrade_button_pressed() -> void:
	Global.upgrade_chosen = true

func load_descriptions():
	var file = FileAccess.open("res://Assets/text files/descriptions.txt", FileAccess.READ)
	while not file.eof_reached(): # iterate through all lines until the end of file is reached
		var line = file.get_line()
		descriptions.append(line)
		print(descriptions)
