extends Area2D

@onready var animation_player = $ButtonSprite
@onready var collider : CollisionShape2D = $ButtonCollider

@onready var level : Node2D = get_tree().get_root().get_node('level')

var activated : bool = false

func _ready() -> void:
	level.end_loop.connect(end_loop)
	animation_player.set_frame(0)

func _on_body_entered(_body):
	if not activated:
		activated = true
		for i in get_overlapping_areas():
			if 'state_change' in i:
				i.state_change(true)

		animation_player.set_frame(1)

func end_loop():
	activated = false
	animation_player.set_frame(0)
