extends Node3D

var sensitivity = 0.8

var rot_max_y = [-2, 80]

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var input = event.screen_relative
		rotation_degrees.y += -input.x * sensitivity
		rotation_degrees.x += input.y * sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, rot_max_y[0], rot_max_y[1])
	
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event is InputEventKey and event.is_action_pressed("ui_cancel") and event.is_pressed():
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
