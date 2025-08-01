extends Area2D
signal button_detection

@onready var animation_player = $AnimatedSprite2D
@onready var level : Node2D = get_tree().get_root().get_node('level')

func _ready() -> void:
	button_detection.connect(level.button_detection)

func _on_body_entered(_body):
	button_detection.emit(true)
	animation_player.play("default")
	
