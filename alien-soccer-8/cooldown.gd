extends ProgressBar

func _physics_process(delta):
	if value <= min_value:
		modulate = Color(0,1,0,1)
	else:
		modulate = Color(1,0,0,1)
