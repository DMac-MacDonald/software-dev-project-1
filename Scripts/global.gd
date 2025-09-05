extends Node

var ink = 100.0
var charging: bool = true
const INK_COST = 1
const INK_REGEN = .2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(charging)
	if ink < 100 and charging:
		ink += INK_REGEN
