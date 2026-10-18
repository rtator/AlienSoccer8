extends Area2D

var linear_velocity : Vector2 = Vector2(0,0)
var base_vel = 1000

var user : Node2D

var returning = false
var has_ball = false
var hit_ball
var hit_parent = false

var ult = false
var ult_speed_mult = 0.8

var offset = 17.0

signal hit(body, is_ball) 
signal delete()

func _ready():
	look_at(linear_velocity + position)

func _physics_process(delta):
	check_delete()
	retract(delta)
	move_and_slide(delta)

func retract(delta):
	if returning and ult:
		if (user.position - position).length() < (base_vel * delta):
			position = user.position
		else:
			linear_velocity = (user.position - position).normalized() * base_vel * ult_speed_mult
			look_at((linear_velocity * -1) + position)
	elif returning and not ult:
		#if (user.position - position).length() < (base_vel * delta):
			#position = user.position
		#else:
			#if has_ball:
				#look_at((hit_ball.linear_velocity) + position)
			user.linear_velocity += (global_position - user.position).normalized() * user.hook_pull_speed

func check_delete():
	if has_ball:
		if hit_parent:
			print(hit_ball.linear_velocity)
			hit_ball.reparent(get_parent())
			hit_ball.rotation = 0
			if ult:
				hit_ball.position = global_position
				hit_ball.linear_velocity = linear_velocity
			delete.emit()
			queue_free()
	elif returning and hit_parent:
		delete.emit()
		queue_free()

func move_and_slide(delta):
	position += linear_velocity * delta

func _on_body_entered(body):
	if body != user and not returning:
		if "ball_speed" in body:
			linear_velocity *= 0
			hit.emit(body, true)
			returning = true
			has_ball = true
			hit_ball = body
			if ult:
				hit_ball.reparent(self)
				body.position = Vector2(offset,0).rotated(rotation)
				
				body.linear_velocity = Vector2(0,0)
			else:
				reparent(hit_ball)
				position = Vector2(-offset,0).rotated(rotation)
			print("hit ball")
		else:
			linear_velocity *= 0
			hit.emit(body, false)
			returning = true
			print("hit wall")
	elif body == user and returning:
		hit_parent = true


func _on_timer_timeout():
	hit_parent = true
