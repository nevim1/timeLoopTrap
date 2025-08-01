extends Area2D

@onready var level : Node2D = get_tree().get_root().get_node('level')

func win(_trash):
	get_tree().call_deferred('change_scene_to_file', "res://scenes/ui/levels_menu.tscn")
