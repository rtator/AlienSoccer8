extends alien

var bullet_load = preload("res://bullet.tscn")
var bullet
var big_shot_load = preload("res://big_shot.tscn")
var big_shot
var bullet_speed = 1000
var shooting = false
var big_shotting = false
var opp_slowed = false
var opp_slowed_big = false
var ult_length = 300

func _ability():
	if cooldown <= 0 and duration <= 0 and not shooting:
		bullet = bullet_load.instantiate()
		var offsetX = 576 - position.x
		print(position.x)
		var offsetVec = Vector2(offsetX, 0).normalized()
		bullet.position = position + (offsetVec * 50)
		bullet.call_deferred("set_axis_velocity", offsetVec * bullet_speed)
		shooting = true
		bullet.shooter = self
		get_parent().add_child(bullet)

func _ultimate():
	if ult_dur <= 0 and charge >= charge_max and not big_shotting:
		big_shot = big_shot_load.instantiate()
		charge = 0
		if player == 1:
			big_shot.scale.x = -1
		var offsetX = 576 - position.x
		var offsetVec = Vector2(offsetX, 0).normalized()
		big_shot.position = position + (offsetVec * 50)
		big_shot.linear_velocity = offsetVec * bullet_speed
		big_shotting = true
		big_shot.shooter = self
		get_parent().add_child(big_shot)

func _ability_cooldown(delta):
	if charge < charge_max and not big_shotting:
		charge += delta
	
	
	if big_shotting:
		if big_shot.delete:
			big_shot.queue_free()
			if opp_slowed_big:
				ult_dur = 75
			big_shotting = false
	elif ult_dur > 0:
		ult_dur -= 1
	elif opp_slowed_big:
		opp_slowed_big = false
		opponent.update_move_speed(opponent.move_speed * 4)
		cooldown = 100
	
	
	if shooting:
		if (bullet.delete):
			bullet.queue_free()
			if opp_slowed:
				duration = 75
			else:
				cooldown = 100
			shooting = false
	elif duration > 0:
		duration -= 1
	elif opp_slowed:
		opp_slowed = false
		opponent.update_move_speed(opponent.move_speed * 3)
		cooldown = 100
	
	if cooldown > 0:
		cooldown -= 1 * delta
		print(cooldown)

func on_ready():
	#physics_material_override.friction = 0.1
	
	base_scale = 0.9
	
	charge_max = 300
	
	update_move_speed(move_speed * 0.9, speed_damp)
