extends Area2D

@onready var ray_cast_2d : RayCast2D = $BoxRaycast
@onready var level : Node2D = get_tree().get_root().get_node('level')
@onready var tile_set : TileMapLayer = level.get_node('TileMapLayer')

var player_scene : PackedScene = preload('res://scenes/tiles/Player.tscn')

var step_history : Array[Vector2] = []

func _ready():
	level.undo.connect(undo)
	level.step.connect(step)
	level.end_loop.connect(end_loop)
	init_history()
	
func init_history():
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
	var new_player = player_scene.instantiate()
	new_player.position = position + Vector2(32,0)
	tile_set.add_child(new_player)
	position = step_history[0]
	init_history()
