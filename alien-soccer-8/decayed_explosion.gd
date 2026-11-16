extends StaticBody2D

var user


func _ready():
	%GPUParticles2D.restart()


func _on_gpu_particles_2d_finished():
	queue_free()


func _on_area_2d_body_entered(body):
	if "temp_speed" in body:
		body.temp_speed = body.ball_speed / 2
		user.health += 200
		user.last_chunk_health = user.health
		user.heal_anim()


func _on_area_2d_body_exited(body):
	if "temp_speed" in body:
		body.temp_speed = body.ball_speed / 2
