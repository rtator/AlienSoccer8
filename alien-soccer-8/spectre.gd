extends alien

var base_spin_speed = 4
var spin_speed = base_spin_speed
var spin_mult = 0.02
var spin_dir = 1

var base_move_speed = 70

var invis_timer = 0
var invising = false

var ulting

func _ability():
	if cooldown <= 0:
		hitbox.scale.x *= -1
		spin_speed *= -1
		spin_dir *= -1
		cooldown = 100

func _ultimate():
	if charge >= charge_max and not ulting:
		ulting = false 
		ult_dur = 150
		ulting = true
		modulate = Color(2,2,2)
		charge = 0

func _ability_cooldown(delta):
	angular_velocity = spin_speed
	sprite.global_rotation = 0
	if spin_speed <= 15:
		spin_speed += (spin_mult * delta) * spin_dir
		update_move_speed(move_speed + (spin_mult * delta * 2))
	
	if charge < charge_max and not ulting:
		charge += delta
	
	if ult_dur > 0:
		ult_dur -= 1 * delta
		spin_speed = 15 * spin_dir
	elif ulting:
		ulting = false
		modulate = Color(1,1,1)
	
	if cooldown > 0:
		cooldown -= 1 * delta
	
	if invis_timer > 50:
		invis_timer -= delta
		
		spin_speed = 15 * spin_dir
		
		var h = 50
		var a =  ((invis_timer - h) / h) - 0.1
		print(a)
		ball.modulate = Color(1,1,1,a)
	elif invis_timer > 0:
		invis_timer -= delta
		
		spin_speed = 15 * spin_dir
		
		var h = 50
		var a = (1 - (invis_timer / h)) - 0.1
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
			invis_timer = 100

func _on_area_2d_body_entered(body):
	if body == ball:
		if ult_dur <= 0:
			spin_speed = base_spin_speed * spin_dir
			update_move_speed(base_move_speed)
			invising = true
			invis_timer = 100
		else:
			invising = true
			invis_timer = 100


func on_ready():
	base_scale = 1
	
	charge_max = 500
	
	update_move_speed(move_speed * 0.8, speed_damp)
