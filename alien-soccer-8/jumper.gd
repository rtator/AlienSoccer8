extends alien

var bluing = false
var blue_strength = 35
var ult_length = 300
var ball_grown = false

var jump_cd = 0

var ground_pounding = false

func _ability():
	if cooldown <= 0:
		ground_pounding = true
		linear_velocity.y = 5000
		cooldown = 150

func _ultimate():
	if ult_dur <= 0 and charge >= charge_max and not bluing:
		charge = 0
		if opponent.character != "jumper":
			opponent.gravity_scale = opponent.move_speed/blue_strength
		else:
			print("grav")
			opponent.gravity_scale *= 2
		bluing = true
		opponent.sprite.modulate  = Color.AQUA
		camera.shake(10)
		ult_dur = ult_length

func _ability_cooldown(delta):
	gravity_scale = move_speed/6.2
	if charge < charge_max and not bluing:
		charge += delta
	
	if ground_pounding and linear_velocity.y == 0:
		camera.shake(500)
		ground_pounding = false
	
	if ult_dur > 0:
		ult_dur -= 1 * delta
		if ult_dur <= 60:
			camera.shake(1)
	elif bluing:
		if opponent.character != "jumper":
			opponent.gravity_scale = 0
		else:
			opponent.gravity_scale /= 2
		opponent.sprite.modulate  = Color.WHITE
		bluing = false
		cooldown == 100
	
	if cooldown > 0:
		cooldown -= 1 * delta
	
	if jump_cd > 0:
		jump_cd -= 1 * delta
	
	if not ground_pounding and jump_cd <= 0 and ((Input.is_action_just_pressed("p1_up") and player == 1) or (Input.is_action_just_pressed("p2_up") and player == 2)):
		linear_velocity.y = -move_speed * 42
		jump_cd = 7

func on_ready():
	physics_material_override.friction = 0.1
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	squish = 500
	base_scale = 1.2
	
	
	charge_max = 350
	
	update_move_speed(move_speed * 0.5, speed_damp * 0.5)
