extends Control


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://startScreen.tscn")

func _on_visuals_button_pressed():
	get_tree().change_scene_to_file("res://settings_visuals.tscn")

func _on_keybinds_button_2_pressed():
	get_tree().change_scene_to_file("res://settings_keybinds.tscn")

func _on_misc_button_pressed():
	get_tree().change_scene_to_file("res://settings_misc.tscn")
