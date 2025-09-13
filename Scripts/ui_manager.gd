extends Control
class_name UIManager

@onready var wave_label: Label = $WaveLabel
@onready var monsters_remaining_label: Label = $MonstersLabel

var wave_manager: WaveManager

func _ready():
	wave_manager = get_node("../Scripts/wave_manager")
	
	# Connect to wave manager signals
	wave_manager.wave_started.connect(_on_wave_started)
	wave_manager.wave_completed.connect(_on_wave_completed)

func _on_wave_started(wave_number: int):
	wave_label.text = "Wave: " + str(wave_number)

func _process(delta):
	if wave_manager:
		monsters_remaining_label.text = "Monsters: " + str(wave_manager.monsters_alive)

func _on_wave_completed():
	# Show wave completion message
	print("Wave completed!")
