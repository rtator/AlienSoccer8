extends RigidBody2D

var delete = false

var shooter
var skin = 0
func _physics_process(delta):
	for ball in shooter.balls:
		if ball.linear_velocity.length() == 0:
			add_collision_exception_with(ball)
		else:
			remove_collision_exception_with(ball)

func _on_body_entered(body):
	if body != shooter:
		delete = true
		if body.has_method("add_speed_mult") and not shooter.opp_slowed and not shooter.opp_slowed_big:
			print("hit")
			body.add_speed_mult(1.0/3.0, 120.0)
			shooter.opp_slowed = true


func _on_timer_timeout():
	delete = true


func _ready():
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
