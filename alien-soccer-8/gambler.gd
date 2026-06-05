extends alien

var changes = []

var ulting = false
func _ability():
	if (cooldown <= 0 and len(changes) <= 0) or ulting:
		var roll = randf_range(0,4)
		
		if roll > 3:
			update_scale(base_scale * 2)
		elif roll > 2:
			update_move_speed(move_speed * 1.5)
		elif roll > 1:
			update_scale(base_scale / 2)
		else:
			update_move_speed(move_speed / 1.5)
		
		if not ulting:
			if roll > 2:
				sprite.animation = "win"
			else:
				sprite.animation = "lose"
		
		var change = [roll, 100]
		changes.push_front(change)

func _ultimate():
	if charge >= charge_max and not ulting and ult_dur <= 0:
		ulting = true
		ult_dur = 200
		charge = 0
		sprite.animation = "ult"

func _ability_cooldown(delta):
	if cooldown > 0:
		cooldown -= delta
	
	if charge <= charge_max and not ulting:
		charge += delta
	
	if ult_dur >= 0:
		ult_dur -= delta
	elif ulting:
		ulting = false
		sprite.animation = "lose"
		
	
	if len(changes) > 0:
		for item in changes:
			item[1] -= delta
			
			if item[1] <= 0:
				var roll = item[0]
				
				if roll > 3:
					update_scale(base_scale / 2)
				elif roll > 2:
					update_move_speed(move_speed / 1.5)
				elif roll > 1:
					update_scale(base_scale * 2)
				else:
					update_move_speed(move_speed * 1.5)
				
				changes.erase(item)
				if not ulting:
					sprite.animation = "default"
					cooldown = 100
				
				break

func on_ready():
	base_scale = 0.9
	
	charge_max = 300
	
	update_move_speed(move_speed * 0.9, speed_damp)
