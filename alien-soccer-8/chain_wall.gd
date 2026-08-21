extends StaticBody2D

var user

func _on_area_2d_body_entered(body):
	if "cooldown" in body:
		user.opp_pause_ult = true
		user.chain_hit = true

func _on_timer_timeout():
	user.wall_out = false
	queue_free()
