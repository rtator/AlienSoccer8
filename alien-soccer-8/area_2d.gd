extends Area2D

var user

func _on_body_entered(body):
	if body == user.opponent:
		user.hit_opp_nuke()

func _on_animation_player_animation_finished(anim_name):
	queue_free()
