extends Area2D
signal button_detection
@onready var animation_player = $AnimatedSprite2D
func _on_body_entered(body):
	button_detection.emit(true)
	animation_player.play("default")
	
