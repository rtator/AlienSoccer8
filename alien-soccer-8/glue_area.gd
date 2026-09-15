extends Area2D

var user

func splat():
	%AnimationPlayer.play("splat")

func _on_body_entered(body):
	if user.gluing and "is_ball" in body:
		body.set_glued(user)

func _on_animation_player_animation_finished(anim_name):
	user.gluing = false
