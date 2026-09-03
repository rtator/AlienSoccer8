extends Path2D

@onready var follow = %PathFollow2D
var dir = 1
var seconds = 3

func _physics_process(delta):
	#if follow.progress_ratio + (dir * delta)/seconds > 0 and follow.progress_ratio + (dir * delta)/seconds < 1:
	follow.progress_ratio = clamp(follow.progress_ratio + (dir * delta)/seconds, 0, 1)

func _on_timer_timeout():
	dir *= -1
