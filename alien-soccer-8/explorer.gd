extends alien

func _ability():
	if cooldown <= 0:
		pass

func _ultimate():
	if ult_dur <= 0 and charge >= charge_max:
		pass
	
func _ability_cooldown(delta):
	if charge < charge_max:
		charge += delta
	
	if ult_dur > 1:
		ult_dur -= 1
	
	if cooldown > 0:
		cooldown -= 1 * delta
	
	if duration > 0:
		duration -= 1 * delta

func on_ready():
	shockwave.user = self
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	base_scale = 1
	
	charge_max = 500
	
	update_move_speed(move_speed, speed_damp)
