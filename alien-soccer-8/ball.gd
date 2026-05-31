extends RigidBody2D

var ball_base_speed = 200
var ball_speed = ball_base_speed

var new_pos = Vector2(200,200)
var reseting = false

func _physics_process(delta):
	linear_velocity = linear_velocity.normalized() * ball_speed
	ball_speed += delta
	if reseting:
		print(%AnimatedSprite2D.global_position)
		global_position = new_pos
		reseting = false

func _on_body_entered(body):
	ball_speed += 10
	#print(ball_speed)
	if body.has_method("add_score"):
		reseting = true
		new_pos = body.add_score()
		linear_velocity = Vector2(0,0)
		ball_speed = ball_base_speed
