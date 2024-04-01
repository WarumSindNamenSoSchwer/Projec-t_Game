extends Camera2D


@onready var slade = $"../Slade"
@onready var slade_cam = $"../Slade/slade_cam"
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
		zoom = lerp(zoom,Vector2(1.0,1.0),speed)
		#print(position)
		

	else:
		switchCamera(slade_cam)
		'''
		position = lerp(position,slade.position,1.0)
		zoom = lerp(zoom,Vector2(1.0,1.0),0.1)
		'''

func switchCamera(newCam):
	newCam.make_current()
	
	

