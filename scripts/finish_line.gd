extends ShapeCast2D

func _process(delta):
	if is_colliding():
		print("win")
