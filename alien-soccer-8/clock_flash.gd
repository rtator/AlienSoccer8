extends CanvasLayer

var speed = 1.1

func flash():
	%clock_flash.color.a = 1

func _physics_process(delta):
	if %clock_flash.color.a > 0.4:
		%clock_flash.color.a -= speed * delta

func finish():
	%clock_flash.color.a = 0
