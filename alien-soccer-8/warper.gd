extends alien

var waypoint_out = false

var waypoint_load = preload("res://waypoint.tscn")
var waypoint

var teleporting = false
var explosion_load = preload("res://warp_explosion.tscn")
var explosion
var teleport_vec

var speed_mult = 1.5
var sped_up = false
var speed_modulate = Color(1.5,1.5,1.5)

func _ability():
	if not waypoint_out and cooldown <= 0 and not sped_up:
		waypoint = waypoint_load.instantiate()
		waypoint.position = position
		add_sibling(waypoint)
		waypoint_out = true
		cooldown = 100
	elif cooldown <= 0 and not sped_up:
		camera.shake(35)
		explosion = explosion_load.instantiate()
		explosion.position = waypoint.position
		add_sibling(explosion)
		
		teleport_vec = waypoint.global_position
		teleporting = true
		waypoint.queue_free()
		
		modulate = speed_modulate
		update_move_speed(move_speed * speed_mult)
		sped_up = true
		duration = 160
		
		cooldown = 250
		waypoint_out = false

func _ultimate():
	if waypoint_out and charge >= charge_max:
		ball.new_pos = waypoint.global_position
		ball.reseting = true
		
		waypoint.queue_free()
		waypoint_out = false
		charge = 0

func _ability_cooldown(delta):
	if charge < charge_max:
		charge += delta
	
	if cooldown > 0 and not sped_up:
		cooldown -= 1 * delta
	
	if teleporting:
		print(global_position)
		position = teleport_vec
		teleporting = false
	
	if duration > 0:
		duration -= 1 * delta
	elif sped_up:
		modulate = Color(1,1,1)
		sped_up = false
		update_move_speed(move_speed / speed_mult)

func on_ready():
	base_scale = 0.8
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	charge_max = 700
	
	update_move_speed(move_speed * 0.8, speed_damp)
