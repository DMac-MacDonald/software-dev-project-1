extends CanvasLayer

func _ready():
	$VBoxContainer/ResumeButton.pressed.connect(self._on_resume_pressed)

func _on_resume_pressed():
	get_tree().paused = false
	queue_free()
