extends Control

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://startScreen.tscn")

func _on_htp_button_pressed():
	get_tree().change_scene_to_file("res://how_to_play.tscn")

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://credits.tscn")

func _on_alien_index_button_pressed():
	get_tree().change_scene_to_file("res://basic_alien_info.tscn")
