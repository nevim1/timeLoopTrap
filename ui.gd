extends Control

var stepLabel

func _ready():
	stepLabel = $Steps

func update_steps(vaulue):
	stepLabel.text = 'Steps left: ' + str(vaulue)
	print(vaulue)
