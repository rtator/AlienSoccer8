extends alien

var batteries = 0
var battery_max = 10
var ability_cost = 3
var ult_cost = 7

var battery_load = preload("res://battery.tscn")
var battery_timer_max = 150
var battery_timer = battery_timer_max
var screen_bounds = [576, 648]

var cluster_bomb_load = preload("res://big_cluster_bomb.tscn")
var cluster_bomb
var cluster_bomb_speed = 1200

var small_cluster_bomb_load = preload("res://small_cluster_bomb.tscn")
var small_cluster_bomb_speed = 300
var push_back_strength = 2000

var opp_slowed = false
var opp_slow_factor = 0.6
var slow_dur_max = 100

var nuke_hit = false
var max_nuke_dur = 120
var nuke_speed = 350

var nuke_load = preload("res://nuke.tscn")
var nuke

var bar_load = preload("res://nuclear_bar.tscn")
var bar

func _ability():
	if batteries >= ability_cost:
		batteries -= ability_cost
		
		cluster_bomb = cluster_bomb_load.instantiate()
		cluster_bomb.position = position
		if player == 1:
			cluster_bomb.linear_velocity.x = cluster_bomb_speed
		else:
			cluster_bomb.linear_velocity.x = cluster_bomb_speed * -1
		
		cluster_bomb.user = self
		
		add_sibling(cluster_bomb)

func _ultimate():
	if batteries >= ult_cost:
		batteries -= ult_cost
		
		nuke = nuke_load.instantiate()
		
		nuke.z_index = opponent.z_index + 1
		
		nuke.position = position
		nuke.target = opponent.position
		nuke.user = self
		
		add_sibling(nuke)

func hit_opp_nuke():
	opponent.stunned = true
	nuke_hit = true
	ult_dur = max_nuke_dur

func hit_opp_cluster(bomb_pos):
	opponent.linear_velocity = ((opponent.position - bomb_pos).normalized() * push_back_strength)
	
	if not opp_slowed:
		opp_slowed = true
		duration = slow_dur_max
		opponent.update_move_speed(opponent.move_speed * opp_slow_factor)

func _ability_cooldown(delta):
	if battery_timer > 0:
		battery_timer -= delta
	else:
		spawn_battery()
	
	cooldown = max(3 - batteries, 0)
	
	charge = min(batteries, 7)
	
	if duration > 0:
		duration -= delta
	elif opp_slowed:
		opp_slowed = false
		opponent.update_move_speed(opponent.move_speed / opp_slow_factor)
	
	if ult_dur > 0:
		ult_dur -= 1 * delta
	elif nuke_hit:
		nuke_hit = false
		opponent.stunned = false

func spawn_battery():
	battery_timer = battery_timer_max
	
	var battery = battery_load.instantiate()
	var position_x = randf_range(screen_bounds[0] - 576, screen_bounds[0])
	var position_y = randf_range(0, screen_bounds[1])
	
	battery.position = Vector2(position_x, position_y)
	battery.z_index = -1
	
	battery.user = self
	add_sibling(battery)

func on_ready(): 
	bar = bar_load.instantiate()
	bar.user = self
	add_sibling(bar)
	
	cooldown = 3
	
	if player == 2:
		screen_bounds = [1152, 648]
	
	base_scale = 1.2
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	charge_max = 7
	
	update_move_speed(move_speed * 0.75, speed_damp)
