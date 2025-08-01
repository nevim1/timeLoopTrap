extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/levels_menu.tscn")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/credits_menu.tscn")

func _on_exit_pressed():
	get_tree().quit()
