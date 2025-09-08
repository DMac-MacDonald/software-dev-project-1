extends Area2D
@onready var timer: Timer = $Timer
@onready var overlap_area: Area2D = $OverlapArea

func _on_timer_timeout() -> void:
	queue_free()

func _process(delta: float) -> void:
	for body in overlap_area.get_overlapping_bodies():
		if body.is_in_group("pixels"):
			queue_free()
