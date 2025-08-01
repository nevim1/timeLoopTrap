extends Area2D
signal box_detection

func _on_body_entered(body):
	box_detection.emit(true)
	


func _on_body_exited(body):
	box_detection.emit(false)
