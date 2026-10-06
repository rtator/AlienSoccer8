extends Control


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://stage_select_screen.tscn")

func _on_game_modes_button_pressed():
	get_tree().change_scene_to_file("res://game_modes.tscn")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://startScreen.tscn")
