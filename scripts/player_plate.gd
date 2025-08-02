extends Area2D
	
func _on_body_exited(_body):
	for i in get_overlapping_areas():
		if 'state_change' in i:
			i.state_change(false)

func _on_body_entered(_body):
	for i in get_overlapping_areas():
		if 'state_change' in i:
			i.state_change(true)
