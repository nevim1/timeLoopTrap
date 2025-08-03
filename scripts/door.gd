extends Area2D

@onready var animation_player = $AnimatedSprite2D
@onready var level : Node2D = get_tree().get_root().get_node('level')

func _ready() -> void:
	level.end_loop.connect(end_loop)
	level.reset_loop.connect(reset_loop)
	animation_player.set_frame(0)
	set_collision_layer_value(4, true)

func open_door():
	set_collision_layer_value(4, false)
	animation_player.play("open")
	
func close_door():
	set_collision_layer_value(4, true)
	animation_player.play("close")
	
func state_change(state : bool):
	if state:
		open_door()
	else:
		close_door()

func end_loop():
	animation_player.set_frame(0)
	set_collision_layer_value(4, true)

func reset_loop():
	end_loop()
