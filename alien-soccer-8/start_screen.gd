extends Control


func _on_button_pressed():
	get_tree().change_scene_to_file("res://alienSelect.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://basic_alien_info.tscn")


func _on_button_4_pressed():
	get_tree().change_scene_to_file("res://webrtc_lobby.tscn")
