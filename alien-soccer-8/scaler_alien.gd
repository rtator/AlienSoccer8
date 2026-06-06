extends alien

var grown = false
var ult_length = 300
var ball_grown = false
var growth_mult = 1.5
var ball_growth_mult = 2

var original_size = 1.3

func _ability():
	if cooldown <= 0 and duration <= 0:
		#update_move_speed(move_speed * speed_mult, speed_damp * damp_mult)
		ball.set_ball_scale(ball_growth_mult)
		ball_grown = true
		duration = 200

func _ultimate():
	if ult_dur <= 0 and charge >= charge_max and not grown:
		charge = 0
		update_scale(original_size * growth_mult)
		grown = true
		ult_dur = ult_length
		camera.shake(15)

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
		var added_size = growth_mult * (ult_dur/ult_length)
		update_scale(original_size + added_size)
		print("size " + str(added_size))
	elif grown:
		update_scale(original_size)
		grown = false
		cooldown == 100
	
	if cooldown > 0:
		cooldown -= 1 * delta
		print(cooldown)

func on_ready():
	base_scale = original_size
	
	charge_max = 600
	
	update_move_speed(move_speed * 0.7, speed_damp)
