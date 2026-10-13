extends Trinket

var player_move_mult = 1.1

func on_ready():
	trinket_name = "running_shoes"
	
	grab_box = %grab
	info_box = %info
	
	control_info_box = %Control
	
	sprite = %sprite

func on_grab():
	PveSave.p1.update_move_speed(PveSave.p1.move_speed * player_move_mult)
	if PveSave.p2 != null:
		PveSave.p2.update_move_speed(PveSave.p2.move_speed * player_move_mult)
