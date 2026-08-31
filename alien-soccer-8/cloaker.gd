extends alien

var bomb_out = false
var bomb
var bomb_load = preload("res://smoke_bomb.tscn")
var bomb_speed = 1000

var ult_bomb_out = false
var ult_bomb
var ult_bomb_load = preload("res://bouncing_canister.tscn")

var cover_load = preload("res://cloaker_cover.tscn")
var cover

var opp_in_smogs = 0
var opp_slow_max = 100
var opp_slow_timer = 0
var opp_slow_factor = 0.4

func _ability():
	if cooldown <= 0 and not bomb_out:
		bomb_out = true
		bomb = bomb_load.instantiate()
		var offsetX = 576 - position.x
		print(position.x)
		var throw_vec = Vector2(offsetX, 0).normalized()
		bomb.position = position + throw_vec * 50
		bomb.linear_velocity = throw_vec * bomb_speed
		bomb.user = self
		
		bomb.z_index = opponent.z_index + 1
		
		add_sibling(bomb)


func _ultimate():
	if charge >= charge_max and not ult_bomb_out:
		ult_bomb_out = true
		charge = 0
		
		ult_bomb = ult_bomb_load.instantiate()
		ult_bomb.position = position
		
		if linear_velocity.length() > 0:
			ult_bomb.linear_velocity = linear_velocity.normalized()
			if (ult_bomb.linear_velocity.x < -0.1 and player == 1) or (ult_bomb.linear_velocity.x > 0.1 and player == 2):
				ult_bomb.linear_velocity.x *= -1
			elif ult_bomb.linear_velocity.x > -0.1 and ult_bomb.linear_velocity.x < 0.1:
				if player == 1:
					ult_bomb.linear_velocity.x = 1
				else:
					ult_bomb.linear_velocity.x = -1
		elif player == 1:
			ult_bomb.linear_velocity = Vector2.RIGHT
		else:
			ult_bomb.linear_velocity = Vector2.LEFT
		
		ult_bomb.linear_velocity.y += randf_range(0.1, 1.1) - 0.6
		
		
		
		ult_bomb.user = self
		ult_bomb.z_index = opponent.z_index + 1
		
		add_sibling(ult_bomb)
		
		
		
		#ult_bomb_out = true
		#bomb = bomb_load.instantiate()
		#var offsetX = 576 - position.x
		#print(position.x)
		#var throw_vec = Vector2(offsetX, 0).normalized()
		#bomb.position = position + throw_vec * 50
		#bomb.linear_velocity = throw_vec * bomb_speed
		#bomb.user = self
		#bomb.is_ult = true
		#
		#bomb.z_index = opponent.z_index + 1
		#
		#add_sibling(bomb)
		#charge = 0

func _ability_cooldown(delta):
	#print(%AnimatedSprite2D.global_scale)
	#print(base_scale)
	if charge < charge_max and not ult_bomb_out:
		charge += delta
	
	if ult_dur > 0:
		ult_dur -= 1 * delta
	
	if cooldown > 0:
		cooldown -= 1 * delta
		print(cooldown)

func on_ready():
	cover = cover_load.instantiate()
	add_sibling(cover)
	
	base_scale = 1
	
	#charge_max = 0
	charge_max = 600
	
	update_move_speed(move_speed * 1.0, speed_damp)
