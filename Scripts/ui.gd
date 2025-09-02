extends CanvasLayer

@onready var ink_meter: ProgressBar = $Control/MarginContainer/VBoxContainer/InkMeter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ink_meter.value = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ink_meter.value = Global.ink
