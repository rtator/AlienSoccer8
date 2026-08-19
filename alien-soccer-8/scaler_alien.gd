extends alien

var grown = false
var ult_length = 300
var ball_grown = false
var growth_mult = 1.5
var small_growth_mult = 1.2
var ball_growth_mult = 2

var slow_mult = 0.8

var original_size = 1.3

var ball_grow_timer = 0

var charges = 0

var arrows_load = preload("res://scaler_arrows.tscn")
var arrows

func _ability():
	if cooldown <= 0 and duration <= 0 and charge >= charge_max and not grown:
		#charges += 1
		update_move_speed(move_speed * slow_mult)
		update_scale(original_size * small_growth_mult)
		duration = 50

func _ultimate():
	if ult_dur <= 0 and charge >= charge_max and not grown:
		growth_mult = 1 + (charges * 0.2)
		update_scale(original_size * growth_mult)
		grown = true
		ult_dur = ult_length
		camera.shake(15)
		charges = 0

func _ability_cooldown(delta):
	if charge < charge_max and not grown:
		charge += delta
	
	if ball_grow_timer > 1 and not ball_grown:
		ball_grow_timer -= 0.5
		ball.set_ball_scale(ball_growth_mult / max(0.73 , ((ball_grow_timer / 5) + 0.73)))
		camera.shake(2)
		
	elif ball_grow_timer > 1 and ball_grown:
		ball_grow_timer -= 0.5
		ball.set_ball_scale(ball_growth_mult * (ball_grow_timer / 5))
		camera.shake(2)
		print(ball_grow_timer)
		
	elif ball_grow_timer > 0 and not ball_grown:
		ball_grow_timer -= 1
		ball.set_ball_scale(ball_growth_mult)
		ball_grown = true
		duration = 200
		camera.shake(9)
	elif ball_grow_timer > 0 and ball_grown:
		ball_grow_timer -= 1
		ball_grown = false
		ball.set_ball_scale(1)
		cooldown = 200
		
	
	if duration > 1:
		duration -= 1
	elif duration > 0:
		duration -= 1
		update_move_speed(move_speed / slow_mult)
		update_scale(original_size)
		cooldown = 350
	
	if ult_dur > 0:
		ult_dur -= 1 * delta
		var added_size = growth_mult * (ult_dur/ult_length)
		update_scale(original_size + added_size)
		print("size " + str(added_size))
	elif grown:
		update_scale(original_size)
		grown = false
	
	if cooldown > 0:
		cooldown -= 1 * delta
		print(cooldown)

func on_ready():
	arrows = arrows_load.instantiate()
	arrows.user = self
	if player == 1:
		arrows.position = Vector2(288, 525)
	else:
		arrows.position = Vector2(864, 525)
	add_sibling(arrows)
	
	base_scale = original_size
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	charge_max = 400
	
	update_move_speed(move_speed * 0.8, speed_damp)



func _on_body_entered(body):
	if body == ball and duration > 0:
		charges += 1
