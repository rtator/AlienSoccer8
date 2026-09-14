extends Area2D

var user

static var in_smog = []

func _on_body_entered(body):
	if body.has_method("add_speed_mult"):
		user.opp_slow_timer = user.opp_slow_max
		
		var slowed = false
		var body_in_smog = false
		for i in in_smog:
			if body == i[0]:
				body_in_smog = true
		
		if not body_in_smog:
			in_smog.append([body, 0])
		
		for i in in_smog:
			if body == i[0]:
				for change in body.speed_changes:
					if change[3] == "cloaker":
						slowed = true
						print("not slow")
						change[0] = user.opp_slow_max
				
				if not slowed:
					print("slow")
					body.add_speed_mult(user.opp_slow_factor, user.opp_slow_max, 1, "cloaker")
				
				i[1] += 1

func _on_body_exited(body):
	if body.has_method("add_speed_mult"):
		for i in in_smog:
			if body == i[0]:
				i[1] -= 1
				if i[1] <= 0:
					for change in body.speed_changes:
						if change[3] == "cloaker":
							change[0] = 0
		

func die():
	print("die")
	queue_free()
