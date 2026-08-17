extends Area2D

var user



func _on_body_entered(body):
	if body == user.ball:
		user.ball.temp_speed = 100
		if user.player == 1:
			user.ball.linear_velocity = Vector2(1,0)
		else:
			user.ball.linear_velocity = Vector2(-1,0)
