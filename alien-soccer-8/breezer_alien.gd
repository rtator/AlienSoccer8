extends alien

var slow_amount_base = 0.15	
var slow_amount_default = 0.2
var slow_amount = slow_amount_base

var ball_in_area = false

@onready var area = %breezer_area
var default_size_mult = 1.5
var bursting = false
var default_modulate = Color(1,1,1,0.318)
var burst_modulate = Color(1.5,1.5,1.5,0.318)
var max_cooldown = 200

var blizzard_vfx_load = preload("res://breezer_blizzard.tscn")
var blizzard_vfx 
var blizzarding = false
var ult_slow = 0.25
var ult_speed = 0.15

func _ability():
	if cooldown <= 0 and duration <= 0 and not bursting:
		area.scale *= default_size_mult
		area.modulate = burst_modulate
		slow_amount = slow_amount_default
		bursting = true
		duration = 50
		cooldown = max_cooldown

func _ultimate():
	if charge >= charge_max and ult_dur <= 0:
		blizzard_vfx.ult()
		
		ult_dur = 200
		blizzarding = true
		charge = 0

func _ability_cooldown(delta):
	if cooldown > 0 and not bursting:
		cooldown -= delta
	
	if duration > 0:
		duration -= delta
	elif bursting:
		bursting = false
		slow_amount = slow_amount_base
		area.scale /= default_size_mult
		area.modulate = default_modulate
	
	if ult_dur > 0:
		ult_dur -= delta
	elif blizzarding:
		blizzarding = false
		ball.temp_speed = 0
		blizzard_vfx.end()
	
	if blizzarding:
		slow_ball_ult()
	
	if charge < charge_max and ball_in_area and ball.linear_velocity.length() > 0 and not blizzarding:
		charge += delta
	
	if ball_in_area and not blizzarding:
		slow_ball()

func slow_ball():
	if ball.linear_velocity.x > 0:
		if player == 1:
			ball.temp_speed = ball.ball_speed * slow_amount
		else:
			ball.temp_speed = -ball.ball_speed * slow_amount
	elif ball.linear_velocity.x < 0:
		if player == 2:
			ball.temp_speed = ball.ball_speed * slow_amount
		else:
			ball.temp_speed = -ball.ball_speed * slow_amount

func slow_ball_ult():
	if ball.linear_velocity.x > 0:
		if player == 1:
			ball.temp_speed = ball.ball_speed * ult_speed
		else:
			ball.temp_speed = -ball.ball_speed * ult_slow
	elif ball.linear_velocity.x < 0:
		if player == 2:
			ball.temp_speed = ball.ball_speed * ult_speed
		else:
			ball.temp_speed = -ball.ball_speed * ult_slow

func _on_breezer_area_body_entered(body):
	if body == ball:
		ball_in_area = true

func _on_breezer_area_body_exited(body):
	if body == ball:
		ball_in_area = false
		ball.temp_speed = 0

func on_ready():
	blizzard_vfx = blizzard_vfx_load.instantiate()
	add_sibling(blizzard_vfx)
	
	base_scale = 0.8
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
		%AnimatedSprite2D.play()
	
	squish *= 2
	stretch *= 2
	
	charge_max = 800
	
	update_move_speed(move_speed * 0.75, speed_damp * 1.0)
