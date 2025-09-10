extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ZOOM_RATE = .1


@onready var camera:Camera2D = %Camera2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim_player.play("pulse")


var is_moving : bool = false
var drawing: bool = false
func _physics_process(delta: float) -> void:
	
	#check if player is moving
	if velocity.x > 0 or velocity.y > 0:
		is_moving = true
	else:
		is_moving = false
		# Get the input direction and handle the movement/deceleration.
		
	#zoom camera in and out
	if Input.is_action_just_pressed("zoom_in"):
		camera.zoom.x += ZOOM_RATE
		camera.zoom.y += ZOOM_RATE
	if Input.is_action_just_pressed("zoom_out"):
		camera.zoom.x -= ZOOM_RATE
		camera.zoom.y -= ZOOM_RATE
		
	#move left and right
	var directionX := Input.get_axis("left", "right")
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#move up and down
	var directionY := Input.get_axis("up", "down")
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	
	if Input.is_action_pressed("draw") and Global.ink > 0:
		drawing = true
	else:
		drawing = false
		
