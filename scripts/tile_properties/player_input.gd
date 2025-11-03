extends Module

# Mapping of input actions to direction vectors (grid based)
const inputs : Dictionary[String, Vector2] = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_down": Vector2.DOWN,
	"move_up": Vector2.UP,
	"wait": Vector2.ZERO
}

# Size of one grid cell
const grid_size : int = 32

var push_limit : int = -1

func _unhandled_input(event : InputEvent):
	for action in inputs.keys():
		if event.is_action_pressed(action):
			var destination: Vector2 = inputs[action] * float(grid_size)
			if move(destination):
			return
