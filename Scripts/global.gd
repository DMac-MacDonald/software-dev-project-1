extends Node

var ink = 100.0
var charging: bool = true
var paused: bool = false
var upgrade_chosen = false
var ink_cost = 1
var ink_regen = .2
var damage = 2
var fruit_health = 100
var monster_health = 20
var width = .5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ink < 100 and charging:
		ink += ink_regen
	if paused:
		get_tree().paused = true
	else:
		get_tree().paused = false
