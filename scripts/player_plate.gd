extends ShapeCast2D
signal player_detection

func _on_body_entered(_body):
	player_detection.emit(true)


func _on_body_exited(_body):
	player_detection.emit(false)
