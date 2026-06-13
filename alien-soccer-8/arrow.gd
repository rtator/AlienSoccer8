extends RigidBody2D

var shooter
var player

var is_arrow = true

func _ready():
	if player == 1:
		%AnimatedSprite2D.flip_h = true

func _on_body_entered(body):
	print("aaaaaaahhh I'm dying!")
	if body.has_method("stop_ball"):
		body.ball_speed -= 10
		body.stop_ball()
	if body.get("is_arrow") == null:
		shooter.cooldown = 150
		queue_free()
