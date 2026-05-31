extends alien

var grown = false
var ball_grown = false
var growth_mult = 1.5
var ball_growth_mult = 2

#var dash_speed = 1500

func _ability():
	if cooldown <= 0 and ult_dur <= 0 and duration <= 0:
		#update_move_speed(move_speed * speed_mult, speed_damp * damp_mult)
		ball.set_ball_scale(ball_growth_mult)
		ball_grown = true
		duration = 200

func _ultimate():
	if cooldown <= 0 and ult_dur <= 0 and charge >= charge_max and not grown:
		charge = 0
		update_scale(growth_mult)
		grown = true
		ult_dur = 50

func _ability_cooldown(delta):
	if charge < charge_max and not grown:
		charge += delta
	
	if duration > 0:
		duration -= 1
	elif ball_grown:
		ball_grown = false
		ball.set_ball_scale(1)
		cooldown = 200
	
	if ult_dur > 0:
		ult_dur -= 1 * delta
	elif grown:
		#update_move_speed(move_speed / speed_mult, speed_damp / damp_mult)
		grown = false
		cooldown == 100
	
	if cooldown > 0:
		cooldown -= 1 * delta
		print(cooldown)

func on_ready():
	base_scale = 1.3
	
	charge_max = 500
	
	update_move_speed(move_speed * 0.7, speed_damp)
