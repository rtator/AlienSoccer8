extends ColorRect

var speed = 1.1

func flash():
	color.a = 1

func _physics_process(delta):
	if color.a > 0:
		color.a -= speed * delta
