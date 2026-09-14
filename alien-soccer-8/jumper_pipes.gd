extends Node2D

var user

var a1_dead = false
var a2_dead = false

func _on_area_2d_body_entered(body):
	if body.has_method("add_speed_mult") and body != user:
		user.ult_hits += 1
		user.add_speed_mult(1.2, 200.0)
		body.add_speed_mult(0.8, 200.0)
		a1_dead = true
		#%Area2D.queue_free()

func _on_area_2d_2_body_entered(body):
	if body.has_method("add_speed_mult") and body != user:
		user.ult_hits += 1
		user.add_speed_mult(1.2, 200.0)
		body.add_speed_mult(0.8, 200.0)
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
