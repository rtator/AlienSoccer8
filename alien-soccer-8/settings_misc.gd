extends Control

func _on_button_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")

func _on_fullscreen_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		%fullscreenButton.text = "Fullscreen: On"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		%fullscreenButton.text = "Fullscreen: Off"

func _on_win_slider_value_changed(value):
	GlobalSave.winMax = value
	var string = str(value)
	string = string.replace(".0", "")
	%winValue.text = string
