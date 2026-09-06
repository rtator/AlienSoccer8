extends ColorRect

var speed = 1.1

func flash():
	color.a = 1

func _physics_process(delta):
	if color.a > 0.4:
		color.a -= speed * delta

func finish():
	color.a = 0
