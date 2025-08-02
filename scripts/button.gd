extends Area2D
signal button_detection

@onready var animation_player = $ButtonSprite
@onready var collider : CollisionShape2D = $ButtonCollider

@onready var level : Node2D = get_tree().get_root().get_node('level')

var activated : bool = false

func _ready() -> void:
	button_detection.connect(level.button_detection)
	level.end_loop.connect(end_loop)
	animation_player.set_frame(0)

func _on_body_entered(_body):
	if not activated:
		activated = true
		print(get_overlapping_areas())
		print(get_overlapping_bodies())
		#collider.get_collider()
		print('button is colliding')
		button_detection.emit(true)
		animation_player.set_frame(1)

func end_loop():
	activated = false
	animation_player.set_frame(0)
