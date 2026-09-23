extends Area3D

var flipped = false

signal trigger

func _on_body_entered(body):
	if not flipped:
		emit_signal("trigger")
		flipped = true
		%AnimationPlayer.play("switch")
