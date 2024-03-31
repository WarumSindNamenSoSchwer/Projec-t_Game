extends CharacterBody2D
@onready var sprite = $AnimatedSprite2D
@onready var camera_2d = $Camera2D

@export var speed: float = 2200.0
@export var sprint_speed: float = 3500.0

@export var jump_height: float = -2000
@export var accel: float = 90.0

@export var friction: float = 50.0
@export var friction_sprinting: float = 100.0

@export var gravity: float = 130

@export var max_jumps: int  = 2
var current_jumps: int = 1
@export var max_dash: int = 2
var current_dash: int = 1


#zoom variables
const BASE_ZOOM = 1.0
const SPRINT_ZOOM = 0.7
const ZOOM_SPEED = 0.1
const TARGET_ZOOM = BASE_ZOOM

func _physics_process(delta):
	var input_dir: Vector2 = input()
	
	if input_dir != Vector2.ZERO:
		accelerate(input_dir, speed)
		sprite.play("run")
	else:

		add_friction(friction)
		sprite.play("default")
		
	jump()
	dash(input_dir)
	
	player_movement()
	
func input() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("left", "right")
	
	if input_dir.x > 0:
		sprite.flip_h = false
	if input_dir.x < 0:
		sprite.flip_h = true
	
	input_dir = input_dir.normalized()
	return input_dir

func dash(direction):
	if Input.is_action_pressed("Sprinting"):
		print(1)
		if current_dash < max_dash:
			velocity = velocity.move_toward(20000 * direction, 4000.0)
			
			current_dash += 1
	if Input.is_action_just_released("Sprinting"):
		add_friction(friction_sprinting)
		current_dash = 1

func accelerate(direction, speed):
	velocity = velocity.move_toward(speed * direction, accel)

func add_friction(frictions):
	velocity = velocity.move_toward(Vector2.ZERO, frictions)
	
func player_movement():
	move_and_slide()
	#play_animation()
	
func jump():
	if Input.is_action_just_pressed("jump"):
		if current_jumps < max_jumps:
			velocity.y = jump_height
			current_jumps += 1
			sprite.play("jump")
	else:
		velocity.y += gravity
		
	if is_on_floor():
		current_jumps = 1
		

