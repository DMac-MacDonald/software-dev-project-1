extends CanvasLayer

@onready var upgrades_container: HBoxContainer = $MarginContainer/UpgradesContainer


const UPGRADE = preload("res://Scenes/upgrade_template.tscn")

func _ready() -> void:
	Global.upgrade_chosen = false
	Global.paused = true
	var upgrade1 = UPGRADE.instantiate()
	var upgrade2 = UPGRADE.instantiate()
	var upgrade3 = UPGRADE.instantiate()
	upgrades_container.add_child(upgrade1)
	upgrades_container.add_child(upgrade2)
	upgrades_container.add_child(upgrade3)

func _process(delta: float) -> void:
	if Global.upgrade_chosen:
		print(Global.upgrade_chosen)
		queue_free()
		Global.paused = false
	else:
		pass
