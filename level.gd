extends Node2D
@export var remaining_steps : int
@export var remaining_loops: int

func _ready():
	var player_node = get_node("Player")
	var ui_steps_node = get_node("UI")
	
	player_node.steps.connect(ui_steps_node.update_steps)



func on_step_taken():
	remaining_steps -= 1

func on_loop_ended():
	remaining_loops -= 1 
	if remaining_loops == 0 :
		_on_loops_depleted()

func _on_loops_depleted():
	get_tree().reload_current_scene()
