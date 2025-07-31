extends Control

@onready var stepLabel = $Steps

func update_steps(value):
	stepLabel.text = 'Steps left: ' + str(value)
