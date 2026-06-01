extends alien

var bluing = false
var blue_strength
var ult_length = 300
var ball_grown = false

func _ability():
	if cooldown <= 0:
		linear_velocity.y = -move_speed * 85
		cooldown = 7

func _ultimate():
	if ult_dur <= 0 and charge >= charge_max and not bluing:
		charge = 0
		if opponent.character != "jumper":
			opponent.gravity_scale = opponent.move_speed/30
		else:
			print("grav")
			opponent.gravity_scale *= 2
		bluing = true
		ult_dur = ult_length

func _ability_cooldown(delta):
	gravity_scale = move_speed/3.1
	if charge < charge_max and not bluing:
		charge += delta
	
	if ult_dur > 0:
		ult_dur -= 1 * delta
	elif bluing:
		if opponent.character != "jumper":
			opponent.gravity_scale = 0
		else:
			opponent.gravity_scale /= 2
		bluing = false
		cooldown == 100
	
	if cooldown > 0:
		cooldown -= 1 * delta
		print(cooldown)

func on_ready():
	physics_material_override.friction = 0.1
	
	squish = 500
	base_scale = 1.3
	
	
	charge_max = 300
	
	update_move_speed(move_speed * 0.25, speed_damp * 0.5)
