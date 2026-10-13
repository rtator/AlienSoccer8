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
			get_tree().paused = false
			%Label.text = "GO!"
		else:
			queue_free()

func _ready():
	get_tree().paused = true
