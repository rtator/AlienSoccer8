extends Trinket

var coin_load = preload("res://pve/scenes/coin.tscn")

func on_ready():
	trinket_name = "coin"
	
	grab_box = %grab
	info_box = %info
	
	control_info_box = %Control
	
	sprite = %sprite

func on_grab():
	PveSave.trinkets.append({"name": trinket_name})
	
	var coin =  coin_load.instantiate()
	coin.global_position = global_position
	PveSave.statue.add_sibling(coin)
