extends Area2D

@onready var animation_player = $ButtonSprite
@onready var collider : CollisionShape2D = $ButtonCollider

@onready var level : Node2D = get_tree().get_root().get_node('level')

var activated : bool = false

var activation_step : int
var sim_step : int = 0

func _ready() -> void:
	level.end_loop.connect(end_loop)
	level.reset_loop.connect(reset_loop)
	level.undo.connect(undo)
	level.step.connect(step)
	animation_player.set_frame(0)

func _on_body_entered(_body):
	if not activated:
		activated = true
		activation_step = sim_step
		for i in get_overlapping_areas():
			if 'state_change' in i:
				i.state_change(true)

		animation_player.set_frame(1)

func end_loop():
	activated = false
	animation_player.set_frame(0)
	sim_step = 0

func reset_loop():
	end_loop()

func step():
	sim_step += 1
	
func undo():
	sim_step -= 1
	if sim_step == activation_step-1:
		activated = false
		animation_player.set_frame(0)
		for i in get_overlapping_areas():
			if 'state_change' in i:
				i.state_change(false)
