extends Area2D
@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	queue_free()

func _process(delta: float) -> void:
	scale.x=Global.width
	scale.y=Global.width
