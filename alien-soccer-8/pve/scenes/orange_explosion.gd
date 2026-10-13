extends Area2D

var strength = 500

var exploded = false

func _ready():
	%GPUParticles2D.restart()

func _on_gpu_particles_2d_finished():
	queue_free()

func _on_body_entered(body):
	if body.has_method("add_speed_mult"):
		body.apply_central_impulse((body.position - position).normalized() * strength)
		exploded = true
		
		body.add_speed_mult(0.7, 100)
