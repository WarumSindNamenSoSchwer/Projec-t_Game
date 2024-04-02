extends Camera2D


@onready var slade = $"../slade"
@onready var slade_cam = $"../slade/slade_cam"
@onready var map_cam = $"."



var start = true
var speed = 0.0

func _ready():
	map_cam.make_current()

func _process(delta):
	
	if Input.is_anything_pressed():
		start = false
		switchCamera(slade_cam)

	
	if start == true:
		if Input.is_anything_pressed():
			start = false
		await get_tree().create_timer(1).timeout
		speed += delta/1000 
		position = lerp(position,slade.position,speed)
		zoom = lerp(zoom,Vector2(3.0,3.0),speed)
		

	else:
		switchCamera(slade_cam)

func switchCamera(newCam):
	newCam.make_current()
	
	

