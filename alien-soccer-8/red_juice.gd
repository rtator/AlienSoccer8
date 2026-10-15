extends Trinket

var player_scale_add = 0.05

func on_ready():
	trinket_name = "red_juice"
	
	grab_box = %grab
	info_box = %info
	
	control_info_box = %Control
	
	sprite = %sprite

func on_grab():
	PveSave.p1.outside_scale_add += player_scale_add
	if PveSave.p2 != null:
		PveSave.p2.outside_scale_add += player_scale_add
