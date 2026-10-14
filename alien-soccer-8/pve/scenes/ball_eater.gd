extends Area2D

signal eaten(ball)


func _on_body_entered(body):
	if "ball_speed" in body:
		eaten.emit(body)
