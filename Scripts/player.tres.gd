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

@export var max_jumps = 2
var current_jumps = 1

var is_sprinting: bool = false

#zoom variables
var base_zoom = 1.0
var sprint_zoom = 0.7
var zoom_speed = 0.1
var target_zoom = base_zoom

func _physics_process(delta):
	var input_dir: Vector2 = input()
	
	if input_dir != Vector2.ZERO:
		if is_sprinting:
			accelerate(input_dir, sprint_speed)
			
		else:
			accelerate(input_dir, speed)
		sprite.play("run")
	else:
		if is_sprinting:
			add_friction(friction_sprinting)
		else:
			add_friction(friction)
		sprite.play("default")
		
	jump()
	sprinting()
	
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

func sprinting ():
	if Input.is_action_pressed("Sprinting"):
		print(1)
		is_sprinting = true
	else:
		is_sprinting = false

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
	else:
		velocity.y += gravity
		
	if is_on_floor():
		current_jumps = 1
		

