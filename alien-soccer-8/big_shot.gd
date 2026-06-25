extends RigidBody2D

var delete = false

var shooter
var skin = 0

func _on_body_entered(body):
	if body != shooter:
		delete = true
		if body.has_method("update_move_speed"):
			print("hit")
			delete = true
			body.update_move_speed(body.move_speed / 4)
			shooter.opp_slowed_big = true


func _on_timer_timeout():
	delete = true

func _ready():
	if skin != 0:
		%AnimatedSprite2D.scale = Vector2(2,2)
		%AnimatedSprite2D.animation = "default_" + str(skin)
		%AnimatedSprite2D.play()
