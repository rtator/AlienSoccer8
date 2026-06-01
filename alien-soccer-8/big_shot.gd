extends RigidBody2D

var delete = false

var shooter

func _on_body_entered(body):
	if not body == shooter:
		delete = true
		if body.has_method("update_move_speed"):
			print("hit")
			body.update_move_speed(body.move_speed / 4)
			shooter.opp_slowed_big = true


func _on_timer_timeout():
	delete = true
