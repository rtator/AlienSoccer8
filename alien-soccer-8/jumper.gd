extends alien

var bluing = false
var blue_strength = 35
var ult_length = 300
var ball_grown = false

var jump_cd = 0

var ground_pounding = false

var ult_hits = 0
var slow_timer = 0

var pipes_load = preload("res://jumper_pipes.tscn")

var shake_strength = 500

func _ability():
	if cooldown <= 0:
		shake_strength = (648 - position.y) * 2
		shake_strength = max(shake_strength, 300)
		
		ground_pounding = true
		linear_velocity.y = 5000
		cooldown = 150

func _ultimate():
	if ult_dur <= 0 and charge >= charge_max and not bluing:
		charge = 0
		
		var pipes = pipes_load.instantiate()
		pipes.position = position
		pipes.user = self
		add_sibling(pipes)
		
		camera.shake(10)

func _ability_cooldown(delta):
	gravity_scale = move_speed/6.2
	if charge < charge_max and not bluing:
		charge += delta
	
	if ground_pounding and linear_velocity.y < 40:
		camera.shake(shake_strength)
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
	
	if slow_timer > 1:
		slow_timer -= 1
	elif slow_timer > 0:
		slow_timer -= 1
		
		opponent.update_move_speed(opponent.move_speed / 0.8)
		update_move_speed(move_speed / 1.2)
		if ult_hits > 1:
			opponent.update_move_speed(opponent.move_speed / 0.8)
			update_move_speed(move_speed / 1.2)
		if ult_hits > 2:
			opponent.update_move_speed(opponent.move_speed / 0.8)
			update_move_speed(move_speed / 1.2)
		
		ult_hits = 0
		
		print("not_slow")

func on_ready():
	physics_material_override.friction = 0.1
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	squish = 500
	base_scale = 1.2
	
	
	charge_max = 400
	
	update_move_speed(move_speed * 0.5, speed_damp * 0.5)
