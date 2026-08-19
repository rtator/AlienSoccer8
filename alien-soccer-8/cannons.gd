extends Node2D

@onready var cannon_1 = %cannon_1
@onready var cannon_2 = %cannon_2

var user

var camera

var cannonball_load = preload("res://cannonball.tscn")

var opp_pos : Vector2

func fire(ult = false, target = Vector2(0,0)):
	#if not ult:
		#target = Vector2(576, randf_range(30, 618))
	
	var fire_vec1 = (target - cannon_1.global_position).normalized()
	var fire_vec2 = (target - cannon_2.global_position).normalized()
	
	if user.player == 1:
		cannon_1.rotation = atan(fire_vec1.y/fire_vec1.x) + deg_to_rad(90)
		cannon_2.rotation = atan(fire_vec2.y/fire_vec2.x) + deg_to_rad(90)
	else:
		cannon_1.rotation = (-1 * (atan(fire_vec1.y/fire_vec1.x) + deg_to_rad(-90)))
		cannon_2.rotation = (-1 * (atan(fire_vec2.y/fire_vec2.x) + deg_to_rad(-90)))
	
	var ball1 = cannonball_load.instantiate()
	ball1.position = cannon_1.global_position + (fire_vec1) * 30
	ball1.linear_velocity = fire_vec1
	ball1.user = user
	ball1.ult = ult
	
	add_sibling(ball1)
	
	var ball2 = cannonball_load.instantiate()
	ball2.position = cannon_2.global_position + (fire_vec2) * 30
	ball2.linear_velocity = fire_vec2
	ball2.user = user
	ball2.ult = ult
	
	add_sibling(ball2)
	
	%particles_1.restart()
	%particles_2.restart()
	camera.shake(20)

func fire_ult(position):
	opp_pos = position
	fire(true, opp_pos)
	%Timer.start()

func _on_timer_timeout():
	fire(true, opp_pos)
