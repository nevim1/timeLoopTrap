extends Area2D

@onready var ray_cast_2d : RayCast2D = $BoxRaycast
@onready var level : Node2D = get_tree().get_root().get_node('level')

var step_history : Array[Vector2] = []

func _ready():
	level.undo.connect(undo)
	level.step.connect(step)
	level.end_loop.connect(end_loop)
	level.reset_loop.connect(reset_loop)
	init_history()
	
func init_history():
	step_history = []
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
	elif ray_cast_2d.get_collision_mask_value(3) : 
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

func end_loop():
	position = step_history[0]
	init_history()

func reset_loop():
	end_loop()		#well the code is the same so why not?
