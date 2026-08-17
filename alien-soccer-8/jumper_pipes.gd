extends Node2D

var user

var a1_dead = false
var a2_dead = false

func _on_area_2d_body_entered(body):
	if body.has_method("update_move_speed") and body != user:
		user.ult_hits += 1
		user.slow_timer = 200
		user.update_move_speed(user.move_speed * 1.2)
		body.update_move_speed(body.move_speed * 0.8)
		a1_dead = true
		#%Area2D.queue_free()

func _on_area_2d_2_body_entered(body):
	if body.has_method("update_move_speed") and body != user:
		user.ult_hits += 1
		user.slow_timer = 200
		user.update_move_speed(user.move_speed * 1.2)
		body.update_move_speed(body.move_speed * 0.8)
		a2_dead = true
		#%Area2D2.queue_free()

func _physics_process(delta):
	if user.player == 1:
		position.x += 7
	elif user.player == 2:
		position.x -= 7
	
	if a1_dead:
		%Area2D.position.y += 50
	if a2_dead:
		%Area2D2.position.y -= 50
