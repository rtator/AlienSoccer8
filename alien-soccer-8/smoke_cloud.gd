extends GPUParticles2D

var user
var is_ult

func _on_finished():
	if not is_ult:
		user.bomb_out = false
		user.cooldown = 200
	else:
		user.ult_bomb_out = false
	queue_free()
