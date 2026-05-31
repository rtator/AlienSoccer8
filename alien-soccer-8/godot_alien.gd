extends alien

var sped_up = false
var dashing = false
var speed_mult = 3
var damp_mult = 1.5

var dash_vec = Vector2(0,0)
var dash_speed = 1000

func _ability():
	if cooldown <= 0 and ult_dur <= 0 and duration <= 0:
		#update_move_speed(move_speed * speed_mult, speed_damp * damp_mult)
		dash_vec = last_input
		dashing = true
		duration = 100

func _ultimate():
	if cooldown <= 0 and ult_dur <= 0 and charge >= charge_max and not sped_up:
		charge = 0
		update_move_speed(move_speed * speed_mult, speed_damp * damp_mult)
		sped_up = true
		ult_dur = 50

func _ability_cooldown(delta):
	if charge < charge_max and not sped_up:
		charge += delta
	
	if duration > 0:
		duration -= 1
		linear_velocity = dash_vec * dash_speed
	elif dashing:
		dashing = false
		cooldown = 200
	
	if ult_dur > 0:
		ult_dur -= 1 * delta
	elif sped_up:
		update_move_speed(move_speed / speed_mult, speed_damp / damp_mult)
		sped_up = false
		cooldown == 100
	
	if cooldown > 0:
		cooldown -= 1 * delta
		print(cooldown)

func on_ready():
	base_scale = 0.7
	
	charge_max = 500
	
	update_move_speed(move_speed, speed_damp / 1.75)
