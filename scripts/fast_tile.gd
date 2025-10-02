extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if "onFastLine" in body:
		body.onFastLine = true


func _on_body_exited(body: Node2D) -> void:
	if "onFastLine" in body:
		body.onFastLine = false
