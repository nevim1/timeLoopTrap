extends Area2D

func _on_area_exited(body):
	if body.get_collision_layer_value(3):
		for i in get_overlapping_areas():
			if 'state_change' in i:
				i.state_change(false)

func _on_area_entered(body):
	if body.get_collision_layer_value(3):
		for i in get_overlapping_areas():
			if 'state_change' in i:
				i.state_change(true)
