extends RigidBody2D

var duration = 10

var exploded = false

var strength = 500

var ball
var user

var flash_length = 0.8
var flash_dif = 0.7
var flashing = false

func _on_timer_timeout():
	if not flashing:
		%AnimatedSprite2D.modulate = Color(2,2,2)
		%Timer.start(flash_length)
		flashing = true
		print("white")
	else:
		flash_length *= flash_dif
		%Timer.start(flash_length)
		%AnimatedSprite2D.modulate = Color(1,1,1)
		flashing = false


func _on_end_timeout():
	exploded = true
	%AnimatedSprite2D.visible = false
	%GPUParticles2D.emitting = true
	%GPUParticles2D.scale *= 3
	%CollisionShape2D.scale *= 3

func _on_gpu_particles_2d_finished():
	queue_free()


func _on_body_entered(body):
	if body != user:
		apply_central_impulse((body.position - position).normalized() * strength)
		exploded = true
		%end.stop()
		%AnimatedSprite2D.visible = false
		%GPUParticles2D.emitting = true
		%GPUParticles2D.scale = Vector2(0.6,0.6)
		%CollisionShape2D.scale = Vector2(3,3)
		linear_velocity *= 0
