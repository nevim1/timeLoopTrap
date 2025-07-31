extends Node2D

@export var remaining_loops: int

var player_node
var ui_steps_node

var last_steps = []
var last_step = null

signal step
signal undo
signal reset

func _ready():
	player_node = get_node("Player")
	ui_steps_node = get_node("UI")

func _unhandled_input(event):
	if not event.is_action_type():
		return
		
	if event.is_action_pressed("reset_level"):
		reset.emit()
		print('level was reset')
		get_tree().reload_current_scene()
		
	elif event.is_action_pressed("undo"):
		undo.emit()
	#elif remaining_steps == 0:

func force_step():
	step.emit()


func on_loop_ended():
	remaining_loops -= 1
	if remaining_loops == 0 :
		on_loops_depleted()

func on_loops_depleted():
	get_tree().reload_current_scene()
