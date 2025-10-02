extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if "on_canon" in body:
		body.on_canon = true


func _on_body_exited(body: Node2D) -> void:
	if "on_canon" in body:
		body.on_canon = false
