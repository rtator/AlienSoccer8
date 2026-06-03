extends RigidBody2D

var ball_base_speed = 200
var ball_speed = ball_base_speed

var new_pos = Vector2(200,200)
var reseting = false

var hit_fx_load = preload("res://hitfx.tscn")
var score_fx_load = preload("res://scorefx.tscn")

@onready var camera = %Camera2D

func _physics_process(delta):
	linear_velocity = linear_velocity.normalized() * ball_speed
	ball_speed += delta
	if reseting:
		print(%AnimatedSprite2D.global_position)
		global_position = new_pos
		reseting = false

func set_ball_scale(new_scale):
	%CollisionShape2D.scale = Vector2(1,1) * new_scale
	%AnimatedSprite2D.scale = Vector2(0.11,0.11) * new_scale

func stop_ball():
	linear_velocity = Vector2(0,0)

func effect_spawn(score = false):
	if GlobalSave.vfxEnabled:
		if score:
			var score_fx = score_fx_load.instantiate()
			score_fx.position = position
			score_fx.emitting = true
			add_sibling(score_fx)
		else:
			var hit_fx = hit_fx_load.instantiate()
			hit_fx.position = position
			hit_fx.emitting = true
			add_sibling(hit_fx)
		
		camera.shake(GlobalSave.screenShake)

func _on_body_entered(body):
	ball_speed += 10
	#print(ball_speed)
	if body.has_method("add_score"):
		effect_spawn(true)
		reseting = true
		new_pos = body.add_score()
		linear_velocity = Vector2(0,0)
		ball_speed = ball_base_speed
	else:
		effect_spawn()
