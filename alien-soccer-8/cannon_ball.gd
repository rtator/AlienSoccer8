extends RigidBody2D

var ball_speed = 400
var ball

var user

var ult = false

var duration = 400

func _ready():
	if ult:
		duration = 500
		%tint.visible = true

func _physics_process(delta):
	linear_velocity = linear_velocity.normalized() * ball_speed
	ball_speed += delta
	
	duration -= delta * 60
	print(duration)
	if duration < 60:
		modulate.a -= delta
	
	if duration <= 0:
		if ult:
			user.ult_balls_out = false
		else:
			user.balls_out = false
			user.cooldown = 500
		
		queue_free()

func _on_body_entered(body):
	ball_speed += 10
	
	if body != user:
		if body.has_method("update_move_speed"):
			print("hit")
			var default_slow = 0.7
			var ult_slow = 0.5
			
			var slow_timer_add = 100
			var slow_amount = default_slow
			if ult:
				slow_timer_add = 150
				slow_amount = ult_slow
			
			if not user.opp_slowed and not user.ult_slowed:
				body.update_move_speed(body.move_speed * slow_amount)
				if ult:
					user.ult_slowed = true
				else:
					user.opp_slowed = true
				user.slow_timer = slow_timer_add
			elif ult and user.opp_slowed:
				body.update_move_speed(body.move_speed / default_slow)
				body.update_move_speed(body.move_speed * slow_amount)
				user.opp_slowed = true
				user.slow_timer = slow_timer_add
				user.opp_slowed = false
			else:
				user.slow_timer += slow_timer_add
				if ult:
					user.opp_slowed = false
					user.ult_slowed = true
