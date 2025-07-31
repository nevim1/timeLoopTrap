extends Area2D
@onready var animation_player = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

func open_door():
	collision.disabled = true
	animation_player.play("default")
func close_door():
	animation_player.play_backwards("default")
	collision.disabled = false
