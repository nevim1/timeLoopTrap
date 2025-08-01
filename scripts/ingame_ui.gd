extends Control


func _on_exit_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_exit_desktop_pressed():
	get_tree().quit()
