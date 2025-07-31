extends Label

var steps_left = 7

func update_steps(value):
	text = "Steps left: " + (steps_left - value)
