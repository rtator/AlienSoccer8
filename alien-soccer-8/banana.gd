extends RigidBody2D

var delete = false

var shooter
var ball

func _on_body_entered(body):
	if body != shooter:
		if body.has_method("add_speed_mult"):
			if not shooter.opp_slipping:
				body.add_speed_mult(-0.5, 50)
				shooter.slip_timer = 50.0
			
			shooter.opp_slipping = true
			queue_free()

func _on_timer_timeout():
	queue_free()


func _ready():
	add_collision_exception_with(ball)
