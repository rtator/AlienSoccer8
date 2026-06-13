extends CanvasLayer

const SOCCER_WORLD = preload("res://soccer_world.tscn")
const PLAYER = preload("res://multiplayer_char.tscn")

func _ready():
	if OS.has_feature("server"):
		Network.start_server()
		hide()
		spawn_world() 

func _on_button_join_pressed():
	on_join()

func on_join():
	Network.join_server()
	spawn_world()
	#spawn_char()
	hide()

func spawn_char():
	var char = PLAYER.instantiate()
	get_tree().current_scene.add_child(char)

func spawn_world():
	var new_world = SOCCER_WORLD.instantiate()
	get_tree().current_scene.add_child.call_deferred(new_world)

func _on_button_quit_pressed():
	get_tree().change_scene_to_file("res://startScreen.tscn")
