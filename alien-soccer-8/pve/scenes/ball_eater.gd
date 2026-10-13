extends Area2D

signal eaten(ball)


func _on_body_entered(body):
	if "ball_speed" in body:
		body.linear_velocity = Vector2(0,0)
		body.disable_collision()
		eaten.emit(body)
