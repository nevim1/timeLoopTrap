extends Area2D
signal button_detection

@onready var animation_player = $Sprite2D

@onready var level : Node2D = get_tree().get_root().get_node('level')

func _ready() -> void:
	button_detection.connect(level.button_detection)
	animation_player.set_frame(0)

func _on_body_entered(_body):
	print('button was pressed')
	button_detection.emit(true)
	animation_player.set_frame(1)
