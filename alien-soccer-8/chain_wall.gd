extends StaticBody2D

var user

var dir = 1
var speed = 15
var shoot_len = 35.0
var shoot_len_max = 35.0

func _ready():
	add_collision_exception_with(user)

func _physics_process(delta):
	shoot_len -= 1
	
	
	if shoot_len > 0:
		position.x += dir * speed
		var ratio = shoot_len/shoot_len_max
		scale = Vector2(1,1) * (1 - ratio)
		print(shoot_len, "max", shoot_len_max)
		print("scale ", 1 - ratio)
		print(scale)
	else:
		set_collision_layer_value(4, true)
		set_collision_layer_value(8, true)
		scale = Vector2(1,1)
		print(scale)

func _on_area_2d_body_entered(body):
	if "cooldown" in body and body != user:
		user.opp_pause_ult = true
		user.chain_hit = true

func _on_timer_timeout():
	user.wall_out = false
	queue_free()
