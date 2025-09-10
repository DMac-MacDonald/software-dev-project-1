extends CharacterBody2D
class_name Monster

@export var speed: float = 100.0
@export var health: int = 1
@export var knockback_strength: float = 200.0
@export var knockback_duration: float = 0.3

var target_position: Vector2
var is_alive: bool = true
var game_manager: Node
var is_knocked_back: bool = false
var knockback_timer: float = 0.0

signal monster_died
signal monster_reached_center

func _ready():
	# Connect hit area signals
	$HitArea.body_entered.connect(_on_marker_hit)
	$HitArea.area_entered.connect(_on_marker_area_hit)
	
	# Find the center of the tablecloth (you'll need to adjust this)
	target_position = get_viewport().size / 2
	
	# Connect to game manager
	game_manager = get_node_or_null("/Scripts/main_menu")#fix

func _physics_process(delta):
	if not is_alive:
		return
	
	# Handle knockback timer
	if is_knocked_back:
		knockback_timer -= delta
		if knockback_timer <= 0:
			is_knocked_back = false
	
	# Only move toward center if not knocked back
	if not is_knocked_back:
		# Move towards center
		var direction = (target_position - global_position).normalized()
		velocity = direction * speed
	
	# Apply movement
	move_and_slide()
	
	# Check if reached center (only if not knocked back)
	if not is_knocked_back and global_position.distance_to(target_position) < 20:
		_reach_center()

func _on_marker_hit(body):
	# Check if the marker is moving and drawing
	if body.name.contains("Marker") or body.has_method("_physics_process"):
		var marker = body as CharacterBody2D
		if marker and marker.has_property("drawing") and marker.drawing:
			# Apply knockback based on marker's velocity direction
			var knockback_direction = (global_position - marker.global_position).normalized()
			apply_knockback(knockback_direction)
			take_damage()

func _on_marker_area_hit(area):
	# Alternative for Area2D markers (if you have any)
	if area.is_in_group("markers"):
		var knockback_direction = (global_position - area.global_position).normalized()
		apply_knockback(knockback_direction)
		take_damage()

func apply_knockback(direction: Vector2):
	if is_alive:
		velocity = direction * knockback_strength
		is_knocked_back = true
		knockback_timer = knockback_duration

func take_damage(damage: int = 1):
	health -= damage
	if health <= 0:
		die()

func die():
	is_alive = false
	monster_died.emit()
	
	# Add death effect here (particles, animation, etc.)
	queue_free()

func _reach_center():
	is_alive = false
	monster_reached_center.emit()
	# Monster "eats" the food - trigger game over or food loss
	queue_free()

func knockback(force: Vector2):
	# Legacy function - kept for compatibility
	velocity += force
