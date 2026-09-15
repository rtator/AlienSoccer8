extends Area2D

var user

func splat():
	%AnimationPlayer.play("splat")
	scale = Vector2(1,1)

func _on_body_entered(body):
	if user.gluing and "is_ball" in body:
		body.set_glued(user)

func _on_animation_player_animation_finished(anim_name):
	user.gluing = false
	scale = Vector2(0,0)
