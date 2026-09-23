extends Control

var ending = false

func end():
	ending = true

func _physics_process(delta):
	if ending:
		%ColorRect.color.a += delta
		if %ColorRect.color.a >= 1:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().change_scene_to_file("res://startScreen.tscn")
