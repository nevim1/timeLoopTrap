extends Node2D
@export var remaining_steps : int
@export var remaining_loops: int

var player_node
var ui_steps_node

var last_steps = []
var last_step = null

signal step

func _ready():
	player_node = get_node("Player")
	ui_steps_node = get_node("UI")
	
	step.connect(ui_steps_node.update_steps)
	
	step.emit(remaining_steps)

# A dictionary that maps input map actions to direction vectors
const inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_down": Vector2.DOWN,
	"move_up": Vector2.UP,
	"wait": Vector2.ZERO
}

# Calls the move function with the appropriate input key
# if any input map action is triggered
func _unhandled_input(event):
	if not event.is_action_type():
		return
		
	if event.is_action_pressed("reset_level"):
		print('level was reset')
		get_tree().reload_current_scene()
		
	elif event.is_action_pressed("undo"):
		last_step = last_steps.pop_back()
		if last_step != null:
			for action in inputs.keys():
				if last_step.is_action_pressed(action):
					if player_node.move(action, true):
						remaining_steps += 1
						step.emit(remaining_steps)

	elif remaining_steps == 0:
		pass
	else:
		for action in inputs.keys():
			if event.is_action_pressed(action):
				if player_node.move(action, false):
					last_steps.append(event)
					remaining_steps -= 1
					step.emit(remaining_steps)


func on_loop_ended():
	remaining_loops -= 1
	if remaining_loops == 0 :
		on_loops_depleted()

func on_loops_depleted():
	get_tree().reload_current_scene()
