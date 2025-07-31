extends ShapeCast2D
signal detection


func _process(_delta):
	if is_colliding():
		detection.emit(true)
