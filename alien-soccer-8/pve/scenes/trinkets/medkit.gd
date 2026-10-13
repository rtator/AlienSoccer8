extends Trinket

func on_ready():
	trinket_name = "medkit"
	
	grab_box = %grab
	info_box = %info
	
	control_info_box = %Control
	
	sprite = %sprite

func on_grab():
	PveSave.statue.health = min(PveSave.statue.health + 1, PveSave.statue.max_health)
