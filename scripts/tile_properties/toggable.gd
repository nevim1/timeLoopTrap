extends Module

@onready collider = get_parent()
@export layer = 3


func _on_area_exited(collider):
	if collider.get_collision_layer_value(layer):
		for i in get_overlapping_areas():
			if 'state_change' in i:
				i.state_change(false)

func _on_area_entered(collider):
	if collider.get_collision_layer_value(layer):
		for i in get_overlapping_areas():
			if 'state_change' in i:
				i.state_change(true)
