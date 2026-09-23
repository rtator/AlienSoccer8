extends Area3D

func _on_body_entered(body):
	if "is_ball" in body and body.is_ball:
		body.linear_velocity.y = 100
		%Control.visible = true
		%Timer.start()

func _on_timer_timeout():
	%Control.end()
