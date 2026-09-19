extends alien

var eating = false
var rushing = false

var health = 1000
var eat_add = 300

var stage = 0
var stage_bounds = [800, 500, 200, 1, 0]
var speed_stages = [0.9, 1, 1.1, 1.2, 0.2]
var size_stages = [1.0, 0.95, 0.9, 0.85, 0.8]
var max_stage = 5

var max_cd = 100
var max_ult_dur = 300

var bar_load = preload("res://decayed_bar.tscn")
var bar

func _ability():
	if cooldown <= 0 and not eating and not rushing:
		eating = true
		
		cooldown = max_cd
		
		%eat_timer.start()
		add_speed_mult(0.5, 16,)
		linear_velocity = linear_velocity.normalized() * move_speed * 10

func _ultimate():
	if charge >= charge_max and ult_dur <= 0:
		modulate = Color(1.5,1,1)
		ult_dur = max_ult_dur
		rushing = true
		charge = 0

func _ability_cooldown(delta):
	if health > stage_bounds[stage] and not rushing:
		health -= delta
	#else:
		#change_stage()
	
	check_stage()
	
	sprite.frame = stage
	
	if cooldown > 0 and not eating:
		cooldown -= delta
	
	if ult_dur > 0:
		ult_dur -= delta
		modulate = Color(1.5,1,1)
	elif rushing:
		rushing = false
		modulate = Color(1,1,1)
	
	if charge <= charge_max and not rushing:
		charge += delta

func check_stage():
	var old_stage = stage
	
	if health > stage_bounds[0]:
		stage = 0
	elif health > stage_bounds[1]:
		stage = 1
	elif health > stage_bounds[2]:
		stage = 2
	elif health > stage_bounds[3]:
		stage = 3
	elif health > stage_bounds[4]:
		stage = 4
	
	if old_stage != stage:
		var speed_mult = speed_stages[stage]/speed_stages[old_stage]
		print("speed mult", speed_stages[stage])
		update_move_speed(move_speed * speed_mult)
		
		var size = size_stages[stage]
		update_scale(size)

func change_stage():
	if stage < max_stage:
		var speed_mult = speed_stages[stage]/speed_stages[stage - 1]
		print("speed mult", speed_stages[stage])
		update_move_speed(move_speed * speed_mult)
		
		var size = size_stages[stage]
		update_scale(size)
		
		stage += 1
	sprite.frame = stage - 1

func on_ready():
	bar = bar_load.instantiate()
	bar.user = self
	add_sibling(bar)
	
	base_scale = 1.0
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
		%AnimatedSprite2D.play()
	
	charge_max = 700
	
	update_move_speed(move_speed * 0.9, speed_damp * 1.0)


func _on_eat_timer_timeout():
	eating = false
	
	health += eat_add
	cooldown = max_cd
	%AnimationPlayer.play("heal")
