extends RigidBody2D

var alpha = 1

var new_scale = Vector2(1.5,1.5)

var user
func _physics_process(delta):
	scale = new_scale
	#new_scale *= 1.1
	
	linear_velocity.x = scale.normalized().x * 2000
	print(scale)
	
	modulate = Color(1,1,1,alpha)
	alpha -= 0.05
	if alpha <= 0:
		queue_free()


func _on_body_entered(body):
	if "temp_speed" in body:
		if body.linear_velocity.length() == 0:
			body.temp_speed = -100
		else:
			body.temp_speed = 150
		queue_free()
	elif body.has_method("update_move_speed") and not body == user:
		body.linear_velocity.x = new_scale.normalized().x * 3000
		queue_free()
