extends Area2D

@onready var particles1 = %GPUParticles2D
@onready var particles2 = %GPUParticles2D2
@onready var collision_shape = %CollisionShape2D

var on = false
var user

func fire():
	on = true
	particles1.emitting = true
	particles2.emitting = true
	collision_shape.disabled = false

func _on_gpu_particles_2d_2_finished():
	user.cooldown = 100
	on = false
	collision_shape.disabled = true

func _on_body_entered(body):
	if "temp_speed" in body:
		body.temp_speed = 100

func _on_body_exited(body):
	if "temp_speed" in body:
		body.temp_speed = 100
