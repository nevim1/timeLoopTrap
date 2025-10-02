extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if "on_fast_line" in body:
		body.on_fast_line = true


func _on_body_exited(body: Node2D) -> void:
	if "on_fast_line" in body:
		body.on_fast_line = false
