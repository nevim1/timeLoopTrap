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
var grid_size = 32

# Reference to the RayCast2D node
@onready var ray_cast_2d: RayCast2D = $PlayerRaycast


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
		#return true
	elif ray_cast_2d.get_collision_mask_value(2) : 
		print("BOX!")
		var movable = ray_cast_2d.get_collider()
		position += destination
		movable.position += destination
	else:
		return false
	return true
