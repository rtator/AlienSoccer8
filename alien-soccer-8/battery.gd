extends Area2D

var user

func _on_body_entered(body):
	if body == user:
		body.batteries += 1
		queue_free()
