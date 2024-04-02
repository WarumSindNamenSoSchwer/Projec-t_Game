extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		modulate = Color(0.0, 1.0, 0.0)
		text = str("pressed")
	else:
		text = str("not pressed")
		modulate = Color(1.0, 0.0, 0.0)
