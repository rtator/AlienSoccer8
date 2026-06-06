extends Control


func _on_shake_slider_value_changed(value):
	GlobalSave.screenShake = value
	%shakeValue.text = str(value)


func _on_button_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")
