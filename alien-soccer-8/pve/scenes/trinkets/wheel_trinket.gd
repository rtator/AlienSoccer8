extends Trinket

var player_move_mult = 1.1

func on_ready():
	trinket_name = "wheel"
	
	grab_box = %grab
	info_box = %info
	
	control_info_box = %Control
	
	sprite = %sprite

func on_grab():
	PveSave.p1.set_deferred("lock_rotation",false)
	PveSave.p1.physics_material_override.friction = 1
	if PveSave.p2 != null:
		PveSave.p2.set_deferred("lock_rotation",false)
		PveSave.p2.physics_material_override.friction = 1
