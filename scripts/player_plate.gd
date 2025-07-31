extends ShapeCast2D
signal player_detected
func _process(_delta):
	if is_colliding():
		player_detected.emit(true)
