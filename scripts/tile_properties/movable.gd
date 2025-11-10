extends Module

@onready var ray_cast_2d : RayCast2D = $MoveRaycast
signal moved

func move(destination : Vector2):
	ray_cast_2d.target_position = destination
	ray_cast_2d.force_raycast_update()

	if not ray_cast_2d.is_colliding():
		moved.emit()
		parent.position += destination

	elif ray_cast_2d.get_collision_mask_value(3):
		var movable = ray_cast_2d.get_collider()
		if 'move' in movable:
			if movable.move(destination):
				parent.position += destination
			else:
				return false
		else:
			return false
	else:
		return false
	moved.emit()
	return true
