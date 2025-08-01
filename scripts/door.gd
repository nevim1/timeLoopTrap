extends Area2D
@onready var animation_player = $Sprite2D
@onready var collision = $CollisionShape2D

func open_door():
	collision.disabled = true
	for i in range(3):
		animation_player.set_frame(i)
	
func close_door():
	for i in [3, 2, 1, 0]:
		animation_player.set_frame(i)
	collision.disabled = false
