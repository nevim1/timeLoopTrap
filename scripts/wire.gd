extends Area2D

@onready var animation_player = $Sprite2D

@onready var level : Node2D = get_tree().get_root().get_node('level')

var wireState : bool = false

func _ready() -> void:
	level.end_loop.connect(end_loop)
	level.reset_loop.connect(reset_loop)
	wireState = false

func state_change(state : bool):
	if wireState != state:
		wireState = state
		for i in get_overlapping_areas():
			if 'state_change' in i:
				i.state_change(state)

		if wireState:
			animation_player.set_frame(1)
		else:
			animation_player.set_frame(0)
		

func end_loop():
	animation_player.set_frame(0)
	wireState = false

func reset_loop():
	end_loop()
