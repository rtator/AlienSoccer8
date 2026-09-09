extends Area2D

var user

var mushroom_load = preload("res://nuke_mushroom.tscn")

#func _ready():
	#var mushroom = mushroom_load.instantiate()
	#mushroom.position = position
	#mushroom.z_index = -1
	#add_sibling(mushroom)

func _on_body_entered(body):
	if body == user.opponent:
		user.hit_opp_nuke()

func _on_animation_player_animation_finished(anim_name):
	queue_free()
