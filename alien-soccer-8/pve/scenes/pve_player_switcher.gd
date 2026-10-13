extends Node2D

func _on_player_2_side_body_exited(body):
	if body.has_method("set_player"):
		body.set_player(1)
		if "sprite" in body:
			body.sprite.flip_h = false

func _on_player_1_side_body_exited(body):
	if body.has_method("set_player"):
		body.set_player(2)
		if "sprite" in body:
			body.sprite.flip_h = true
