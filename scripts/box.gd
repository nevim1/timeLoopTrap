extends Area2D

@onready var ray_cast_2d : RayCast2D = $BoxRaycast

var step_history : Array[Vector2] = []

func _ready():
	get_tree().get_root().get_node('level').undo.connect(undo)
	get_tree().get_root().get_node('level').step.connect(step)
	step_history.append(position)

func move(destination, limit):
	if limit > -1:
		limit -= 1
		if limit < 0:
			return false
	
	ray_cast_2d.target_position = destination
	ray_cast_2d.force_raycast_update()
	if not ray_cast_2d.is_colliding():
		position += destination
	elif ray_cast_2d.get_collision_mask_value(2) : 
		var movable = ray_cast_2d.get_collider()
		if 'move' in movable:
			if movable.move(destination, limit):
				position += destination
			else:
				return false
		else:
			return false
	else:
		return false
	return true

func step():
	step_history.append(position)

func undo():
	if not len(step_history) == 1:
		var last_position = step_history[-2]
		step_history.pop_back()
		position = last_position
