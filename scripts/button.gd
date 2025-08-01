extends Area2D
signal button_detection
@onready var animation_player = $Sprite2D

func _on_body_entered(_body):
	button_detection.emit(true)
	animation_player.set_frame(1)
