extends ShapeCast2D
signal player_detection

func _on_body_entered(body):
	player_detection.emit(true)


func _on_body_exited(body):
	player_detection.emit(false)
