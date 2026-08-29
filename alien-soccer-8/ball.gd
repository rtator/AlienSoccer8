extends RigidBody2D

var ball_base_speed = 200
var max_ball_base_speed = 350
var ball_speed = ball_base_speed

var temp_speed = 0

var new_pos = Vector2(200,200)
var reseting = false

var hit_fx_load = preload("res://hitfx.tscn")
var score_fx_load = preload("res://scorefx.tscn")

@onready var camera = %Camera2D

var speed_add = 10

var side = 0

func _physics_process(delta):
	linear_velocity = linear_velocity.normalized() * (ball_speed + temp_speed)
	ball_speed += delta
	if reseting:
		print(%AnimatedSprite2D.global_position)
		position = new_pos
		if position.x > 576:
			side = 1
		else:
			side = 0
		%Timer.start()
		reseting = false

func set_ball_scale(new_scale):
	%CollisionShape2D.scale = Vector2(1,1) * new_scale
	%AnimatedSprite2D.scale = Vector2(0.11,0.11) * new_scale

func stop_ball():
	linear_velocity = Vector2(0,0)

func effect_spawn(score = false):
	if GlobalSave.vfxEnabled:
		if score:
			%score_sfx.play()
			
			var score_fx = score_fx_load.instantiate()
			score_fx.position = position
			score_fx.emitting = true
			add_sibling(score_fx)
		else:
			%ball_hit_sfx.play()
			
			var hit_fx = hit_fx_load.instantiate()
			hit_fx.position = position
			hit_fx.emitting = true
			add_sibling(hit_fx)
		
		camera.shake(GlobalSave.screenShake)

func _on_body_entered(body):
	%Timer.stop()
	
	ball_speed += speed_add
	temp_speed = 0
	#print(ball_speed)
	if body.has_method("add_score"):
		if ball_base_speed <= max_ball_base_speed:
			ball_base_speed += 10
		effect_spawn(true)
		reseting = true
		new_pos = body.add_score()
		linear_velocity = Vector2(0,0)
		ball_speed = ball_base_speed
	else:
		effect_spawn()


func _on_timer_timeout():
	var vel_x = randf_range(0.1, 1)
	var vel_y = randf_range(-1, 1)
	if side == 1:
		vel_x *= -1
	linear_velocity = Vector2(vel_x, vel_y)
