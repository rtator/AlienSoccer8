extends alien

var ball_slowed = false
var all_slowed = false
var speed_mult = 3
var damp_mult = 1.5

var dash_vec = Vector2(0,0)
var dash_speed = 1500

var ball_hit
var clock_ball_speed = [200]

var ball_slow = 2.5
var all_slow = 3.0

var flash_load = preload("res://clock_flash.tscn")
var flash

func _ability():
	if cooldown <= 0 and not ball_slowed and not all_slowed and duration <= 0 and not %clock_aoe.firing:
		%clock_aoe.fire()
		%clock_aoe.firing = true

func hit_ball(ball):
		sprite.animation = "slowed"
		if skin != 0:
			%AnimatedSprite2D.animation = "slowed_" + str(skin)
		
		ball_hit = ball
		clock_ball_speed = [ball.ball_speed]
		ball.ball_speed /= ball_slow
		ball_slowed = true
		duration = 100

func _ultimate():
	if ult_dur <= 0 and charge >= charge_max and not all_slowed and not ball_slowed:
		sprite.animation = "slowed"
		if skin != 0:
			%AnimatedSprite2D.animation = "slowed_" + str(skin)
		charge = 0
		for ball in balls:
			clock_ball_speed.push_back(ball.ball_speed)
			ball.ball_speed /= all_slow
			ball.speed_add /= all_slow
		
		for opp in opponent:
			opp.add_speed_mult(1.0/all_slow)
		all_slowed = true
		ult_dur = 100
		
		flash.flash()

func _ability_cooldown(delta):
	if charge < charge_max and not all_slowed:
		charge += delta
	
	if duration > 0:
		duration -= delta
	elif ball_slowed:
		sprite.animation = "default"
		if skin != 0:
			%AnimatedSprite2D.animation = "default_" + str(skin)
		ball_slowed = false
		ball_hit.ball_speed = clock_ball_speed[0]
		ball_hit.speed_add = 10
		cooldown = 400
		%clock_aoe.firing = false
	
	if balls[0].linear_velocity.length() == 0:
		ult_dur = 0
	elif ult_dur > 0:
		ult_dur -= 1 * delta
	elif all_slowed:
		flash.finish()
		
		sprite.animation = "default"
		if skin != 0:
			%AnimatedSprite2D.animation = "default_" + str(skin)
		
		for ball_i in range(clock_ball_speed):
			balls[ball_i].ball_speed = clock_ball_speed[ball_i]
			all_slowed = false
	
	if cooldown > 0:
		cooldown -= 1 * delta

func on_ready():
	flash = flash_load.instantiate()
	flash.z_index = max(opponent[0].z_index, z_index) + 1
	add_sibling(flash)
	
	%clock_aoe.user = self
	
	base_scale = 0.8
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	squish *= 1.5
	stretch *= 1.5
	
	charge_max = 700
	
	update_move_speed(move_speed * 0.8, speed_damp)
