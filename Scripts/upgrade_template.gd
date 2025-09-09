extends MarginContainer

@onready var upgrade_description: Label = $PanelContainer/VBoxContainer/UpgradeDescription
@onready var upgrade_picture: TextureRect = $PanelContainer/VBoxContainer/UpgradePicture
@onready var upgrade_name: Label = $PanelContainer/VBoxContainer/UpgradeName

var descriptions = []
var names = []
var rng = RandomNumberGenerator.new()
var randomNum
func _ready() -> void:
	load_descriptions()
	load_names()
	var random = int(rng.randf_range(0, descriptions.size()-1))
	randomNum = random
	upgrade_description.text = descriptions[random]
	upgrade_name.text = names[random]
	match random:
		0:#++width
			upgrade_picture.texture = preload("res://Assets/Sprites/Line_Width_Up1.png")
		1:#++damage
			pass
		2:#--enemy health
			pass
		3:#++fruit health
			pass
		4:#++ink charge
			upgrade_picture.texture = preload("res://Assets/Sprites/Ink_Charge_Up1.png")
		5:#--ink cost
			upgrade_picture.texture = preload("res://Assets/Sprites/Ink_Cost_Down1.png")
func _on_upgrade_button_pressed() -> void:
	
	match randomNum:
		0:#++width
			Global.width += (Global.width * .2)
			print(Global.width)
		1:#++damage
			pass
		2:#--enemy health
			pass
		3:#++fruit health
			pass
		4:#++ink charge
			Global.ink_regen += (Global.ink_regen * .2)
			print(Global.ink_regen)
		5:#--ink cost
			Global.ink_cost -= (Global.ink_regen * .2)
			print(Global.ink_cost)
	Global.upgrade_chosen = true
	

func load_descriptions():
	var file = FileAccess.open("res://Assets/text files/descriptions.txt", FileAccess.READ)
	while not file.eof_reached(): # iterate through all lines until the end of file is reached
		var line = file.get_line()
		descriptions.append(line)

func load_names():
	var file = FileAccess.open("res://Assets/text files/names.txt", FileAccess.READ)
	while not file.eof_reached(): # iterate through all lines until the end of file is reached
		var line = file.get_line()
		names.append(line)
