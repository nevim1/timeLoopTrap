extends Area2D
@onready var animation_player = $Sprite2D

@onready var level : Node2D = get_tree().get_root().get_node('level')

func _ready() -> void:
	level.end_loop.connect(end_loop)
	#level.button_pressed.connect(button_pressed)
	#level.b_plate_pressed.connect(b_plate_pressed)
	#level.p_plate_pressed.connect(p_plate_pressed)
	set_collision_layer_value(4, true)

func open_door():
	set_collision_layer_value(4, false)
	for i in range(4):
		animation_player.set_frame(i)
	
func close_door():
	set_collision_layer_value(4, true)
	for i in range(3, -1, -1):
		animation_player.set_frame(i)

func button_pressed():
	print('doors got signal that button was pressed')
	open_door()
	
func b_plate_pressed():
	print("doors got signal that pressure plate was pressed")
	
func p_plate_pressed():
	print("doors got signal that player plate was pressed")
	
func state_change(state : bool):
	print('got activate from button')
	if state:
		open_door()
	else:
		close_door()

func end_loop():
	animation_player.set_frame(0)
	set_collision_layer_value(4, true)
