extends Control


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://play_screen.tscn")


func _on_as_64_button_pressed():
	get_tree().change_scene_to_file("res://as_64_level_select.tscn")
