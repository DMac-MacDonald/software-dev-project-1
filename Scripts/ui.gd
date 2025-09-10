extends CanvasLayer

@onready var ink_meter: ProgressBar = $Control/MarginContainer/VBoxContainer/InkMeter
@onready var animation_player: AnimationPlayer = $Control/MarginContainer/VBoxContainer/InkMeter/AnimationPlayer
@onready var charge_timer: Timer = $Control/MarginContainer/VBoxContainer/InkMeter/AnimationPlayer/ChargeTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ink_meter.value = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.ink <= 0:
		animation_player.play("InkEmpty")
	ink_meter.value = Global.ink

func _on_charge_timer_timeout() -> void:
	charge_timer.autostart = false
	Global.charging = true

func set_charge (val: bool):
	if Global.charging != val:
		Global.charging = val
