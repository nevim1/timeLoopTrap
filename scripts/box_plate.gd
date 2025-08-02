extends Area2D

func _on_area_exited(_body):
	#get_collision_layer_value()
	print(_body)
	for i in get_overlapping_areas():
		if 'state_change' in i:
			i.state_change(false)

func _on_area_entered(_body):
	print(_body)
	for i in get_overlapping_areas():
		if 'state_change' in i:
			i.state_change(true)
