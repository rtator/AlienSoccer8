extends Camera2D

var shake_amount = 0
var shake_fade = 0.8

var zoomed_left = false

func shake(strength):
	shake_amount = strength

func _process(delta):
	offset = get_shake_vec(shake_amount)
	
	shake_amount *= shake_fade
	
	if zoom.length() > Vector2(1,1).length():
		if zoomed_left:
			zoom.x -= 0.001
			zoom.y -= 0.001
			position.x += 1152*0.0005
			Engine.time_scale += 0.01
		else:
			zoom.x -= 0.001
			zoom.y -= 0.001
			position.x -= 1152*0.0005
			Engine.time_scale += 0.01
	elif Engine.time_scale > 1:
		Engine.time_scale = 1
		print(Engine.time_scale)

func zoom_left():
	zoomed_left = true
	Engine.time_scale = 0.1
	zoom.x += 0.1
	zoom.y += 0.1
	position.x -= 1152 * 0.05

func zoom_right():
	zoomed_left = false
	Engine.time_scale = 0.1
	zoom.x += 0.1
	zoom.y += 0.1
	position.x += 1152 * 0.05

func get_shake_vec(amount):
	return Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))
	
