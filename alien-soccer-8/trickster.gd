extends alien

var banana_load = preload("res://banana.tscn")
var banana
var bullet_speed = 500
var opp_slipping = false
var slip_timer = 0
var ult_length = 300

func _ability():
	if cooldown <= 0:
		banana = banana_load.instantiate()
		var offsetX = 576 - position.x
		print(position.x)
		var offsetVec = Vector2(offsetX, 0).normalized()
		banana.position = position + (offsetVec * 50)
		banana.call_deferred("set_linear_velocity", offsetVec * bullet_speed)
		banana.shooter = self
		banana.ball = ball
		add_sibling(banana)
		cooldown = 400

func _ultimate():
	if charge >= charge_max:
		charge = 0
		banana = banana_load.instantiate()
		var offsetX = 576 - position.x
		print(position.x)
		var offsetVec = Vector2(offsetX, offsetX).normalized()
		banana.position = position + (offsetVec * 50)
		banana.call_deferred("set_linear_velocity", offsetVec * bullet_speed)
		banana.shooter = self
		banana.ball = ball
		add_sibling(banana)
		
		banana = banana_load.instantiate()
		offsetX = 576 - position.x
		print(position.x)
		offsetVec = Vector2(offsetX, -offsetX).normalized()
		banana.position = position + (offsetVec * 50)
		banana.call_deferred("set_linear_velocity", offsetVec * bullet_speed)
		banana.shooter = self
		banana.ball = ball
		add_sibling(banana)
		
		banana = banana_load.instantiate()
		offsetX = 576 - position.x
		print(position.x)
		offsetVec = Vector2(offsetX, 0).normalized()
		banana.position = position + (offsetVec * 50)
		banana.call_deferred("set_linear_velocity", offsetVec * bullet_speed)
		banana.shooter = self
		banana.ball = ball
		add_sibling(banana)

func _ability_cooldown(delta):
	if charge < charge_max:
		charge += delta
	
	if cooldown > 0:
		cooldown -= 1 * delta
	
	if slip_timer >= 0:
		slip_timer -= 1
		if slip_timer <= 20:
			camera.shake(1)
	elif opp_slipping:
		opp_slipping = false
		opponent.update_move_speed(abs(opponent.move_speed * 2))

func on_ready():
	base_scale = 0.8
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	charge_max = 600
	
	update_move_speed(move_speed * 0.6, speed_damp * 0.5)
