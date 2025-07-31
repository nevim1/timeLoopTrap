extends CharacterBody2D

# A dictionary that maps input map actions to direction vectors
const inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_down": Vector2.DOWN,
	"move_up": Vector2.UP,
	"wait": Vector2.ZERO
}

# Stores the grid size, which is 32 (same as one tile)
const grid_size : int = 32

var clone : bool = false

var step_history : Array[Vector2] = []

@export var push_limit : int = -1
@export var remaining_steps : int = 20

# Reference to the RayCast2D node
@onready var ray_cast_2d: RayCast2D = $PlayerRaycast
@onready var ui_steps_node = get_tree().get_root().get_node('level/UI')
@onready var level = get_tree().get_root().get_node('level')

func _ready():
	level.undo.connect(undo)
	ui_steps_node.update_steps(remaining_steps)
	step_history.append(position)

# Updates the direction of the RayCast2D according to the input key
# and moves one grid if no collision is detected
func move(action, reverse:bool):
	var direction = 1
	if reverse:
		direction *= -1
		
	var destination = inputs[action] * grid_size * direction
	ray_cast_2d.target_position = destination
	ray_cast_2d.force_raycast_update()
	if not ray_cast_2d.is_colliding():
		position += destination
	elif ray_cast_2d.get_collision_mask_value(2) : 
		var movable = ray_cast_2d.get_collider()
		if 'move' in movable:
			if movable.move(destination, push_limit):
				position += destination
			else: 
				return false
		else: 
			return false
	else:
		return false
	return true
	
func _unhandled_input(event: InputEvent) -> void:
	if remaining_steps == 0:
		return
		
	for action in inputs.keys():
		if event.is_action_pressed(action):
			if move(action, false):
				step_history.append(position)
				remaining_steps -= 1
				ui_steps_node.update_steps(remaining_steps)
				level.force_step()
				return

func undo():
	if not len(step_history) == 1:
		var last_position = step_history[-2]
		step_history.pop_back()
		position = last_position
		remaining_steps += 1
		ui_steps_node.update_steps(remaining_steps)
