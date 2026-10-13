extends Control

var level

func _on_button_pressed():
	#level.trying_to_unpause = true
	level.unpause()

func _on_button_2_pressed():
	Engine.time_scale = 1
	get_tree().paused = false
	if PveSave.is_pve:
		get_tree().change_scene_to_file("res://game_modes.tscn")
	else:
		get_tree().change_scene_to_file("res://stage_select_screen.tscn")
