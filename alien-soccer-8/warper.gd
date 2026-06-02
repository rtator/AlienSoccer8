extends alien

var waypoint_out = false


func _ultimate():
	if waypoint_out and charge >= charge_max:
		waypoint

func _ability_cooldown(delta):
	if charge < charge_max and not ult_mode:
	
	if ult_dur > 0:
		
	elif ult_mode:
	
	if cooldown > 0:
		cooldown -= 1 * delta
		print(cooldown)
	
	if duration > 0:
		duration -= 1 * delta

func on_ready():
	base_scale = 1
	
	charge_max = 500
	#charge_bar = %p1Charge
	
	#set_player(1)
	update_move_speed(move_speed, speed_damp)
