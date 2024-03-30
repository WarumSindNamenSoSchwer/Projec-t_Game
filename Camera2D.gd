extends Camera2D


@onready var slade = $"../Slade"
@onready var camera_2d = $"."


var start = true
var speed = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	print(4)
	
	
	
	if Input.is_anything_pressed():
		start = false
		print(1)
	

	
	if start == true:
		print(3)
		if Input.is_anything_pressed():
			start = false
			print(2)
		await get_tree().create_timer(1).timeout
		speed += delta/1000 
		position = lerp(position,slade.position,speed)
		zoom = lerp(zoom,Vector2(1.0,1.0),speed)
		#print(position)
		
	else:
		position = lerp(position,slade.position,0.1)
		zoom = lerp(zoom,Vector2(1.0,1.0),0.1)
		


