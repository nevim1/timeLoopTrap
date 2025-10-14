extends Module

var level : Node2D

func _ready():
	if root.find_child('level'):
		level = root.get_node('level')
		print(level)

func win(_trash):
	var level_name = level.scene_file_path
	var regex = RegEx.new()
	regex.compile(r"level_(\d+)\.tscn")
	var result = regex.search(level_name)
	var levelnumber = result.get_string(1)
	var next_level_path = "res://scenes/levels/level_%d.tscn" % (int(levelnumber) + 1)
	if ResourceLoader.exists(next_level_path):
		get_tree().call_deferred('change_scene_to_file', next_level_path)
		return
	get_tree().call_deferred('change_scene_to_file', "res://scenes/ui/levels_menu.tscn")
