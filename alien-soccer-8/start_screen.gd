extends Control


func _on_button_pressed():
	get_tree().change_scene_to_file("res://newAlienSelect.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://basic_alien_info.tscn")

func _on_button_5_pressed():
	get_tree().change_scene_to_file("res://how_to_play.tscn")










func _on_button_4_pressed():
	get_tree().change_scene_to_file("res://webrtc_lobby.tscn")

func _ready():
	if OS.has_feature("server"):
		OS.set_environment("server", "true")
	
	if OS.has_environment("server") or OS.has_environment("FLY_PROCESS_GROUP"):
		get_tree().change_scene_to_file("res://webrtc_lobby.tscn")
