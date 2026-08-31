extends Area2D

var user

func _on_body_entered(body):
	if body == user.opponent:
		user.opp_slow_timer = user.opp_slow_max
		if user.opp_in_smogs <= 0:
			user.opponent.update_move_speed(user.opponent.move_speed * user.opp_slow_factor)
		
		user.opp_in_smogs += 1

func _on_body_exited(body):
	if body == user.opponent:
		user.opp_in_smogs -= 1
		if user.opp_in_smogs <= 0:
			user.opponent.update_move_speed(user.opponent.move_speed / user.opp_slow_factor)

func die():
	print(die)
	queue_free()
