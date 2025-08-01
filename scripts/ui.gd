extends Control

@onready var stepLabel = $BoxContainer/Steps

func update_steps(value):
	stepLabel.text = 'Steps left: ' + str(value)
