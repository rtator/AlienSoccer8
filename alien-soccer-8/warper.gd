extends alien

var waypoint_out = false

var waypoint_load = preload("res://waypoint.tscn")
var waypoint

var teleporting = false
var explosion_load = preload("res://warp_explosion.tscn")
var explosion
var teleport_vec

func _ability():
	if not waypoint_out and cooldown <= 0:
		waypoint = waypoint_load.instantiate()
		waypoint.position = position
		add_sibling(waypoint)
		waypoint_out = true
		cooldown = 100
	elif cooldown <= 0 :
		camera.shake(35)
		explosion = explosion_load.instantiate()
		explosion.position = waypoint.position
		add_sibling(explosion)
		
		teleport_vec = waypoint.global_position
		teleporting = true
		waypoint.queue_free()
		cooldown = 200
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
	
	if cooldown > 0:
		cooldown -= 1 * delta
	
	if teleporting:
		print(global_position)
		position = teleport_vec
		teleporting = false
	
	if duration > 0:
		duration -= 1 * delta

func on_ready():
	base_scale = 0.8
	
	charge_max = 700
	
	update_move_speed(move_speed * 0.8, speed_damp)
