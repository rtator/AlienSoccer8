extends Control


func _on_ability_button_pressed():
	get_tree().change_scene_to_file("res://how_to_play_ability.tscn")

func _on_how_to_play_button_pressed():
	get_tree().change_scene_to_file("res://how_to_play.tscn")

func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://how_to_play_controls.tscn")

func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://startScreen.tscn")
