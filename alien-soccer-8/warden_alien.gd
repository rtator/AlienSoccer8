extends alien

var max_cd = 400
var full_default_dur = 90
var full_ult_dur = 200

var opp_paused = false
var opp_pause_length = 0
var opp_pause_ult = false
var opp_cd = 0
var opp_charge = 0

var chain_load = preload("res://chainbolt.tscn")
var chainbolt
var bolt_out = false
var chain_hit = false
var chain_dead = false

var wall_load = preload("res://chain_wall.tscn")
var wall
var wall_out = false
var wall_hit = false
var wall_dead = false

var lock_load = preload("res://warden_lock.tscn")
var lock

var cover_load = preload("res://warden_cover.tscn")
var cover

func _ability():
	if cooldown <= 0 and duration <= 0 and not bolt_out and not wall_out:
		opp_pause_ult = false
		bolt_out = true
		
		chainbolt = chain_load.instantiate()
		chainbolt.user = self
		chainbolt.position = position
		
		if player == 1:
			chainbolt.dir = 1
		else:
			chainbolt.dir = -1
		
		add_sibling(chainbolt)

func _ultimate():
	if charge >= charge_max and not wall_out:
		wall_out = true
		
		wall = wall_load.instantiate()
		wall.user = self
		wall.position = position
		if player == 1:
			wall.dir = 1
			#wall.position = Vector2(864, 0)
		else:
			wall.dir = -1
			#wall.position = Vector2(288, 0)
		
		add_sibling(wall)
		
		
		charge = 0

func _ability_cooldown(delta):
	if chain_dead:
		chain_dead = false
		bolt_out = false
		
		if not opp_pause_ult:
			cooldown = max_cd
	
	if chain_hit:
		chain_hit = false
		opp_paused = true
		
		if opp_pause_ult:
			opp_pause_length = 100
		else:
			opp_pause_length = 150
		
		opponent.cooldown += 5
		opponent.charge -= 5
		
		opp_cd = opponent.cooldown
		opp_charge = opponent.charge
		
		opponent.modulate = Color(0.8,0.8,0.8)
		lock.visible = true
		
		if player == 1:
			cover.p1()
		else:
			cover.p2()
	
	
	if opp_paused and opp_pause_length > 0:
		opp_pause_length -= 1
		opponent.cooldown = opp_cd
		opponent.charge = opp_charge
	elif opp_paused:
		opp_paused = false
		opponent.modulate = Color(1,1,1)
		lock.visible = false
		
		if player == 1:
			cover.p1_done()
		else:
			cover.p2_done()
	
	
	if cooldown > 0:
		cooldown -= 1 * delta
	
	if duration > 0:
		duration -= 1 * delta
	
	if charge <= charge_max and not wall_out:
		charge += delta

func on_ready():
	lock = lock_load.instantiate()
	lock.visible = false
	opponent.add_child(lock)
	
	cover = cover_load.instantiate()
	add_sibling(cover)
	
	base_scale = 1.15
	
	charge_max = 650
	
	update_move_speed(move_speed * 0.85, speed_damp)
