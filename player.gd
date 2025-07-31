extends CharacterBody2D

# A dictionary that maps input map actions to direction vectors
const inputs = {
	"moveRight": Vector2.RIGHT,
	"moveLeft": Vector2.LEFT,
	"moveDown": Vector2.DOWN,
	"moveUp": Vector2.UP
}

# Stores the grid size, which is 32 (same as one tile)
var grid_size = 32
var current_loop: bool = true
signal step
# Reference to the RayCast2D node
@onready var ray_cast_2d: RayCast2D = $RayCast2D


# Updates the direction of the RayCast2D according to the input key
# and moves one grid if no collision is detected
func move(action):
	if current_loop == true :
		var destination = inputs[action] * grid_size
		ray_cast_2d.target_position = destination
		ray_cast_2d.force_raycast_update()
		if not ray_cast_2d.is_colliding():
			position += destination
			return true
		return false
