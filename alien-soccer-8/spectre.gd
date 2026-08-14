extends alien

var base_spin_speed = 4
var spin_speed = base_spin_speed
var spin_mult = 0.02
var spin_dir = 1

var base_move_speed = 70 * 0.8

var invis_timer = 0
var invising = false

var ulting

func _ability():
	if cooldown <= 0:
		hitbox.scale.x *= -1
		%CollisionShape2D2.scale.x *= -1
		spin_speed *= -1
		spin_dir *= -1
		cooldown = 100

func _ultimate():
	if charge >= charge_max and not ulting:
		%CollisionShape2D2.disabled = false
		%CollisionShape2D2.visible = true
		
		ulting = false 
		ult_dur = 150
		ulting = true
		modulate = Color(2,2,2)
		charge = 0

func _ability_cooldown(delta):
	position.y = clamp(position.y, 32, 616)
	if player == 1:
		position.x = clamp(position.x, 32, 544)
	else:
		position.x = clamp(position.x, 608, 1120)
	
	angular_velocity = spin_speed
	sprite.global_rotation = 0
	if abs(spin_speed) <= 15:
		spin_speed += (spin_mult * delta) * spin_dir
		print(move_speed + (spin_mult * delta * 2) - (spin_speed * 2))
		update_move_speed(move_speed + (spin_mult * delta * 2))
	else:
		update_move_speed(48 + (spin_mult * delta * 2))
	
	if charge < charge_max and not ulting:
		charge += delta
	
	if ult_dur > 0:
		ult_dur -= 1 * delta
		spin_speed = 15 * spin_dir
	elif ulting:
		ulting = false
		modulate = Color(1,1,1)
		%CollisionShape2D2.disabled = true
		%CollisionShape2D2.visible = false
	
	if cooldown > 0:
		cooldown -= 1 * delta
	
	if invis_timer > 50:
		invis_timer -= delta
		
		spin_speed = 15 * spin_dir
		
		var h = 60
		var a =  ((invis_timer - h) / h) - 0.3
		print(a)
		ball.modulate = Color(1,1,1,a)
	elif invis_timer > 0:
		invis_timer -= delta
		
		spin_speed = 15 * spin_dir
		
		var h = 60
		var a = (1 - (invis_timer / h)) - 0.3
		print(a)
		ball.modulate = Color(1,1,1,a)
	elif invising:
		ball.modulate = Color(1,1,1)

func _on_body_entered(body):
	if body == ball:
		if ult_dur <= 0:
			spin_speed = base_spin_speed * spin_dir
			update_move_speed(base_move_speed)
		else:
			invising = true
			invis_timer = 120

func _on_area_2d_body_entered(body):
	if body == ball:
		if ult_dur <= 0:
			spin_speed = base_spin_speed * spin_dir
			update_move_speed(base_move_speed)
			invising = true
			invis_timer = 120
		else:
			invising = true
			invis_timer = 120


func on_ready():
	base_scale = 1
	
	if skin != 0:
		if skin != 3:
			%AnimatedSprite2D.scale = Vector2(0.19, 0.19)
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	charge_max = 500
	
	update_move_speed(move_speed * 0.8, speed_damp)
