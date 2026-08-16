extends Control

var level

func _on_button_pressed():
	level.unpause()

func _on_button_2_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://startScreen.tscn")
