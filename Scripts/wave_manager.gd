extends Node
class_name WaveManager

@export var monster_scene: PackedScene
@export var spawn_radius: float = 400.0
@export var base_monsters_per_wave: int = 3
@export var wave_multiplier: float = 1.5

var current_wave: int = 0
var monsters_alive: int = 0
var wave_active: bool = false
var spawn_points: Array[Vector2] = []
var center_position: Vector2

signal wave_completed
signal game_over
signal wave_started(wave_number: int)

func _ready():
	# Set center position (adjust to your tablecloth center)
	center_position = get_viewport().size / 2
	generate_spawn_points()

func generate_spawn_points():
	# Generate points around the tablecloth border
	spawn_points.clear()
	var points_count = 16 # Number of potential spawn points
	
	for i in points_count:
		var angle = (i * 2 * PI) / points_count
		var point = center_position + Vector2(cos(angle), sin(angle)) * spawn_radius
		spawn_points.append(point)

func start_next_wave():
	current_wave += 1
	wave_active = true
	monsters_alive = 0
	
	var monsters_to_spawn = int(base_monsters_per_wave * pow(wave_multiplier, current_wave - 1))
	
	wave_started.emit(current_wave)
	
	# Spawn monsters with slight delay between each
	for i in monsters_to_spawn:
		await get_tree().create_timer(0.5).timeout
		spawn_monster()

func spawn_monster():
	if not monster_scene:
		print("Monster scene not assigned!")
		return
	
	var monster = monster_scene.instantiate()
	
	# Random spawn position around border
	var spawn_pos = spawn_points[randi() % spawn_points.size()]
	# Add some randomization to avoid exact same spots
	spawn_pos += Vector2(randf_range(-50, 50), randf_range(-50, 50))
	
	monster.global_position = spawn_pos
	monster.target_position = center_position
	
	# Connect monster signals
	monster.monster_died.connect(_on_monster_died)
	monster.monster_reached_center.connect(_on_monster_reached_center)
	
	get_tree().current_scene.add_child(monster)
	monsters_alive += 1
	
	# Add spawn effect
	create_spawn_effect(spawn_pos)

func create_spawn_effect(position: Vector2):
	# Simple spawn effect - you can make this more elaborate
	var tween = create_tween()
	
	# You could add particles, flash effects, etc. here
	# For now, we'll just print
	print("Monster spawned at: ", position)

func _on_monster_died():
	monsters_alive -= 1
	check_wave_completion()

func _on_monster_reached_center():
	# Monster reached center - game over or lose life
	game_over.emit()
	print("Monster reached the center! Game Over!")

func check_wave_completion():
	if monsters_alive <= 0 and wave_active:
		wave_active = false
		wave_completed.emit()
		
		# Wait a moment before starting next wave
		await get_tree().create_timer(2.0).timeout
		start_next_wave()
