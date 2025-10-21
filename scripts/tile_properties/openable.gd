extends Module

@onready var animation_player = get_node("../AnimatedSprite2D")
@onready var level : Node2D = get_node('level')
@onready var object_collider  = get_parent()
func _ready() -> void:
	level.end_loop.connect(end_loop)
	level.reset_loop.connect(reset_loop)
	animation_player.set_frame(0)

func open():
	object_collider.set_collision_layer_value(4, false)
	animation_player.play("open")


func close():
	object_collider.set_collision_layer_value(4, true)
	animation_player.play("close")

func state_change(state : bool):
	if state:
		open()
	else:
		close()

func end_loop():
	object_collider.set_collision_layer_value(4, true)
	animation_player.play("close")

func reset_loop():
	end_loop()
