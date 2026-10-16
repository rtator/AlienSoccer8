extends Trinket

var player_move_mult = 1.1

func on_ready():
	trinket_name = "batteries"
	
	grab_box = %grab
	info_box = %info
	
	control_info_box = %Control
	
	sprite = %sprite

func on_grab():
	PveSave.trinkets.append({"name": trinket_name})
	PveSave.p1.cooldown_mult *= 1.2
	PveSave.p1.charge_mult *= 1.2
	if PveSave.p2 != null:
		PveSave.p2.cooldown_mult *= 1.2
		PveSave.p2.charge_mult *= 1.2
