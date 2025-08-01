extends Area2D

@onready var level : Node2D = get_tree().get_root().get_node('level')

func win(_trash):
	print("win")
