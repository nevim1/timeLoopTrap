extends Area2D
@onready var animation_player = $Sprite2D

@onready var level : Node2D = get_tree().get_root().get_node('level')

func _ready() -> void:
	level.end_loop.connect(end_loop)
	set_collision_layer_value(4, true)

func open_door():
	set_collision_layer_value(4, false)
	for i in range(4):
		animation_player.set_frame(i)
	
func close_door():
	set_collision_layer_value(4, true)
	for i in range(3, -1, -1):
		animation_player.set_frame(i)
	
func state_change(state : bool):
	if state:
		open_door()
	else:
		close_door()

func end_loop():
	animation_player.set_frame(0)
	set_collision_layer_value(4, true)
