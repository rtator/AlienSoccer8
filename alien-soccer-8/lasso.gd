extends Area2D

var ball
var user

var ball_grabbed = false

func _on_body_entered(body):
	if body == ball:
		add_child(body)
		ball_grabbed = true
		ball.reseting = true
		var new_pos = Vector2(575,-600)
		ball.linear_velocity = Vector2(0,0)
		ball.new_pos = new_pos
		%AnimatedSprite2D2.visible = true
		ball.visible = false

#func _physics_process(delta):
	#if ball_grabbed:
		#add_sibling(ball)
		#print(ball.global_position)
		#ball.position = Vector2(30,-45)
		#ball.linear_velocity = Vector2(0,0)

func _on_tree_exiting():
	if ball_grabbed:
		ball.reseting = true
		var new_pos = user.position
		if user.player == 1:
			new_pos.x += 50
			ball.linear_velocity = Vector2(1,0)
		else:
			new_pos.x -= 50
			ball.linear_velocity = Vector2(-1,0)
		ball.new_pos = new_pos
		ball.position = new_pos
		user.add_sibling(ball)
		ball.visible = true
