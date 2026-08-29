extends Control

var slow_speed = 0.02

var num = 3

func _process(delta):
	modulate.a -= slow_speed
	
	if modulate.a <= 0:
		modulate.a = 1
		num -= 1
		if num > 0:
			%Label.text = str(num)
		elif num == 0:
			Engine.time_scale = 1
			%Label.text = "GO!"
		else:
			queue_free()

func _ready():
	Engine.time_scale = 0
