extends Control


func _on_1_pressed():
	get_tree().change_scene_to_file("res://3d/level/level_1.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://game_modes.tscn")
