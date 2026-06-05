extends RigidBody2D

var delete = false

var shooter
var ball

func _on_body_entered(body):
	if body != shooter:
		if body.has_method("update_move_speed"):
			print("hit")
			body.update_move_speed(body.move_speed * -1)
			shooter.opp_slipping = true
			shooter.slip_timer = 50
			queue_free()

func _on_timer_timeout():
	queue_free()


func _ready():
	add_collision_exception_with(ball)
