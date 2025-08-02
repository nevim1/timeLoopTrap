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
var step_delta_history : Array[Vector2] = []
var replay_step : int = 0

var push_limit : int = -1
var remaining_steps : int

var can_create_clones : bool = false

# Reference to the RayCast2D node
@onready var ray_cast_2d: RayCast2D = $PlayerRaycast
@onready var player_sprite : Sprite2D = $PlayerSprite
@onready var ui_steps_node = get_tree().get_root().get_node('level/UI')
@onready var level : Node2D = get_tree().get_root().get_node('level')

func _ready():
	print(transform)
	
	remaining_steps = level.step_limit
	push_limit = level.push_limit
	can_create_clones = level.can_loop
	
	level.undo.connect(undo)
	level.end_loop.connect(end_loop)
	level.step.connect(step)
	
	ui_steps_node.update_steps(remaining_steps)
	
	step_history.append(position)
	

# Updates the direction of the RayCast2D according to the input key
# and moves one grid if no collision is detected
func move(destination : Vector2):
	ray_cast_2d.target_position = destination
	ray_cast_2d.force_raycast_update()
	if not ray_cast_2d.is_colliding():
		position += destination
	elif ray_cast_2d.get_collision_mask_value(3) : 
		var movable = ray_cast_2d.get_collider()
		if 'move' in movable:
			print('player collided with box')
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
	if clone: 
		return
		
	if remaining_steps == 0:
		return
		
	for action in inputs.keys():
		if event.is_action_pressed(action):
			var destination = inputs[action] * grid_size
			if move(destination):
				step_history.append(position)
				step_delta_history.append(destination)
				remaining_steps -= 1
				ui_steps_node.update_steps(remaining_steps)
				level.force_step()
				return

func undo():
	if clone:
		replay_step -= 1
		position = step_history[replay_step%len(step_history)]
	else:
		if not len(step_history) == 1:
			var last_position = step_history[-2]
			step_history.pop_back()
			step_delta_history.pop_back()
			position = last_position
			remaining_steps += 1
			ui_steps_node.update_steps(remaining_steps)
		
func end_loop():
	if not clone:
		clone = true
		player_sprite.modulate = Color(1,1,1,0.5)
		position = step_history[0]
		replay_step = 0
		
func step():
	if clone:
		if (replay_step) % (len(step_history)) == (len(step_history) - 1):
			position = step_history[0]
		else:
			move(step_history[((replay_step+1)%len(step_history))] - step_history[((replay_step)%len(step_history))])
		replay_step += 1
