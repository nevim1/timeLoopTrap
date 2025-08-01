extends Area2D
@onready var animation_player = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var level : Node2D = get_tree().get_root().get_node('level')

func _ready() -> void:
	level.button_pressed.connect(button_pressed)

func open_door():
	set_collision_layer_value(4, false)
	animation_player.play("default")
	
func close_door():
	set_collision_layer_value(4, true)
	animation_player.play_backwards("default")

func button_pressed():
	open_door()
