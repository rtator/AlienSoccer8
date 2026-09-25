extends Area2D

var user



func _on_body_entered(body):
	if "temp_speed" in body:
		body.temp_speed = 100
		if user.player == 1:
			body.linear_velocity = Vector2(1,0)
		else:
			body.linear_velocity = Vector2(-1,0)
