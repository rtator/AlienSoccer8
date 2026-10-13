extends Trinket

var barricade = preload("res://pve/scenes/barricade.tscn")

var trinket_info = {
	"name": "barricade",
	"on_start": func ():
		var barricade = preload("res://pve/scenes/barricade.tscn")
		barricade =  barricade.instantiate()
		PveSave.statue.add_child(barricade)
}

var rot_mult = 100
var sprite_rot = 0

func on_ready():
	trinket_name = "barricade"
	
	grab_box = %grab
	info_box = %info
	
	control_info_box = %Control
	
	sprite = %sprite

func anim(delta):
	if sprite != null:
		sprite.rotation_degrees += sprite_rot
		%statue.rotation_degrees = -sprite_rot
		sprite_rot += delta * rot_mult

func on_grab():
	PveSave.trinkets.append(trinket_info)
