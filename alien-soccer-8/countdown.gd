extends Control

var slow_speed = 0.02

var num = 3

var init = false

func _process(delta):
	delta = 1.0 + (1/3) * delta
	
	if init:
		init = false
		get_tree().paused = true
	
	modulate.a -= slow_speed * delta
	
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
	init = true
	#get_tree().paused = true
