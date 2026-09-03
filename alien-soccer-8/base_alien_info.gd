extends Control

const alien_screens = {
	"basic": "res://basic_alien_info.tscn",
	"speedy": "res://speedy_alien_info.tscn",
	"scaler": "res://scaler_alien_info.tscn",
	"jumper": "res://jumper_alien_info.tscn",
	"launcher": "res://launcher_alien_info.tscn",
	"freezer": "res://freezer_alien_info.tscn",
	"clock": "res://clock_alien_info.tscn",
	"trickster": "res://trickster_alien_info.tscn",
	"gambler": "res://gambler_alien_info.tscn",
	"wrangler": "res://wrangler_alien_info.tscn",
	"twins": "res://twins_alien_info.tscn",
	"warper": "res://warper_alien_info.tscn",
	"target": "res://target_alien_info.tscn",
	"spectre": "res://spectre_alien_info.tscn",
	"mosquito": "res://mosquito_alien_info.tscn",
	"cloaker": "res://cloaker_alien_info.tscn",
	"pirate": "res://pirate_alien_info.tscn",
	"mothership": "res://mothership_alien_info.tscn",
	"warden": "res://warden_alien_info.tscn",
}

func set_screen(alien):
	get_tree().change_scene_to_file(alien_screens[alien])

func _on_basic_pressed():
	set_screen("basic")

func _on_speedy_pressed():
	set_screen("speedy")

func _on_scaler_pressed():
	set_screen("scaler")

func _on_jumper_pressed():
	set_screen("jumper")

func _on_launcher_pressed():
	set_screen("launcher")

func _on_freezer_pressed():
	set_screen("freezer")

func _on_clock_pressed():
	set_screen("clock")

func _on_trickster_pressed():
	set_screen("trickster")

func _on_gambler_pressed():
	set_screen("gambler")

func _on_wrangler_pressed():
	set_screen("wrangler")

func _on_twins_pressed():
	set_screen("twins")

func _on_warper_pressed():
	set_screen("warper")

func _on_target_pressed():
	set_screen("target")

func _on_spectre_pressed():
	set_screen("spectre")

func _on_mosquito_pressed():
	set_screen("mosquito")

func _on_cloaker_pressed():
	set_screen("cloaker")

func _on_pirate_pressed():
	set_screen("pirate")

func _on_mothership_pressed():
	set_screen("mothership")

func _on_warden_pressed():
	set_screen("warden")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://startScreen.tscn")
