extends RigidBody2D

var y_vel = 700
var x_vel = 300

func _ready():
	var start_vel = Vector2(randf_range(-x_vel, x_vel), -y_vel)
	linear_velocity = start_vel
	
	add_collision_exception_with(PveSave.statue)

func _on_body_entered(body):
	if "ball_speed" in body:
		add_collision_exception_with(body)
	else:
		stop()

func stop():
	freeze = true
	var flip = randi_range(0, 1)
	%sprite.stop()
	%sprite.frame = flip * 2
	
	%Label.visible = true
	$Timer.start()
	if flip == 0:
		%Label.text = "Heads!"
		PveSave.statue.health = min(PveSave.statue.health + 2, PveSave.statue.max_health)
	else:
		%Label.text = "Tails"
		PveSave.statue.get_hurt(1)

func _on_timer_timeout():
	queue_free()
