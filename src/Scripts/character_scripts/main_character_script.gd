extends CharacterBody2D

@onready var player_sprite = $player_sprite


@export var speed = 200.0
@export var acceleration = 1870.0
@export var jump_velocity = -300.0
var deceleration = acceleration * 0.96

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		player_sprite.play("jump")
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	if Input.is_action_pressed("left"):
		player_sprite.flip_h = true
		velocity.x = max(velocity.x - acceleration * get_physics_process_delta_time(), -speed)
		player_sprite.play("walk")
		
	if Input.is_action_pressed("right"):
		player_sprite.flip_h = false
		velocity.x = min(velocity.x + acceleration * get_physics_process_delta_time(), speed)
		player_sprite.play("walk")
		
	if velocity.x > 0:
		velocity.x = max(0, velocity.x - deceleration * delta)
	elif velocity.x < 0:
		velocity.x = min(0, velocity.x + deceleration * delta)
		
	if velocity.x == 0:
		player_sprite.play("default")
	
	move_and_slide()
