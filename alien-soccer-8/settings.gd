extends Control


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://startScreen.tscn")

func _on_visuals_button_pressed():
	get_tree().change_scene_to_file("res://settings_visuals.tscn")
