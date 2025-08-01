extends Area2D
@onready var animation_player = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var level : Node2D = get_tree().get_root().get_node('level')

func _ready() -> void:
	level.button_pressed.connect(button_pressed)

func open_door():
	set_collision_layer_value(4, false)
	for i in range(3):
		animation_player.set_frame(i)
	
func close_door():
	set_collision_layer_value(4, true)
	for i in [3, 2, 1, 0]:
		animation_player.set_frame(i)

func button_pressed():
	open_door()
