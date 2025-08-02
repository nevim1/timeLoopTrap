extends Area2D

func _on_area_exited(_body):
	print(get_collision_layer_value(3))
	print(_body)
	for i in get_overlapping_areas():
		if 'state_change' in i:
			i.state_change(false)

func _on_area_entered(_body):
	print(get_collision_layer_value(3))
	print(_body)
	for i in get_overlapping_areas():
		if 'state_change' in i:
			i.state_change(true)
