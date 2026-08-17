extends RigidBody2D

var user

func _on_body_entered(body):
	if body == user.ball:
		user.camera.shake(30)
		visible = false
		%CollisionShape2D.disabled = true
		print(%CollisionShape2D.disabled)
		#contact_monitor = false
		#sleeping = true
