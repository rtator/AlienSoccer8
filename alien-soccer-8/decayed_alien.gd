extends alien

var eating = false
var rushing = false

var health = 1000
var max_health = 1100
var last_chunk_health = health
var eat_add = 300
var chunk_heal = 150

var stage = 0
var stage_bounds = [800, 500, 200, 1, 0]
var speed_stages = [0.9, 1, 1.1, 1.2, 0.2]
var size_stages = [1.0, 0.95, 0.9, 0.85, 0.8]
var max_stage = 5

var max_cd = 100
var max_ult_dur = 500

var bar_load = preload("res://decayed_bar.tscn")
var bar

var chunk_load = preload("res://decayed_chunk.tscn")
var chunks := []

var screen_bounds = [536, 608]

func _ability():
	if cooldown <= 0 and not eating and not rushing and len(chunks) > 0:
		
		cooldown = max_cd
		closest_chunk().explode()
		health -= 100
		
		
		#eating = true
		#
		#cooldown = max_cd
		#
		#%eat_timer.start()
		#add_speed_mult(0.5, 16,)
		#linear_velocity = linear_velocity.normalized() * move_speed * 10

func _ultimate():
	if charge >= charge_max and ult_dur <= 0 and health >= 850:
		health -= 850
		
		last_chunk_health = health
		for i in range(8):
			spawn_chunk(true)
		
		
		add_speed_mult(1.2, max_ult_dur)
		modulate = Color(1.5,1,1)
		ult_dur = max_ult_dur
		rushing = true
		charge = 0

func _ability_cooldown(delta):
	if health > max_health:
		health = max_health
	elif health <= 0:
		health = 0
	
	if health > stage_bounds[stage] and not rushing:
		health -= delta
	#else:
		#change_stage()
	
	if not rushing:
		check_stage()
	
	sprite.frame = stage
	
	if last_chunk_health - 100 >= health:
		last_chunk_health = health
		spawn_chunk()
	
	if cooldown > 0 and not eating:
		cooldown -= delta * cooldown_mult
	
	if ult_dur > 0:
		ult_dur -= delta
		modulate = Color(1.5,1,1)
	elif rushing:
		rushing = false
		modulate = Color(1,1,1)
	
	if charge <= charge_max and not rushing:
		charge += delta * charge_mult
	
	if health < 800 and charge >= charge_max:
		charge = charge_max - 0.3
	
	for chunk in chunks:
		chunk.glowing = false
	
	if len(chunks) > 0:
		var close_chunk = closest_chunk()
		close_chunk.glowing = true

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

func spawn_chunk(scatter = false):
	if len(chunks) < 8:
		var chunk = chunk_load.instantiate()
		if scatter:
			chunk.position = Vector2(randf_range(screen_bounds[0] - 536, screen_bounds[0]), randf_range(20, screen_bounds[1]))
		else:
			chunk.position = position
		chunk.user = self
		chunks.append(chunk)
		add_sibling(chunk)

func change_stage():
	if stage < max_stage:
		var speed_mult = speed_stages[stage]/speed_stages[stage - 1]
		print("speed mult", speed_stages[stage])
		update_move_speed(move_speed * speed_mult)
		
		var size = size_stages[stage]
		update_scale(size)
		
		stage += 1
	sprite.frame = stage - 1

func closest_chunk():
	var closest_dist
	var closest_chunk
	for chunk in chunks:
		for ball in balls:
			var dist = chunk.position.distance_to(ball.position)
			if closest_chunk == null or dist < closest_dist:
				closest_dist = dist
				closest_chunk = chunk
	
	return(closest_chunk)

func on_ready():
	
	if player == 2:
		screen_bounds = [1132, 628]
	
	bar = bar_load.instantiate()
	bar.user = self
	add_sibling(bar)
	
	base_scale = 1.0
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
		%AnimatedSprite2D.play()
	
	charge_max = 700
	
	update_move_speed(move_speed * 0.9, speed_damp * 1.0)

func heal_anim():
	if not rushing:
		%AnimationPlayer.play("heal")


func _on_eat_timer_timeout():
	eating = false
	
	health += eat_add
	cooldown = max_cd
	heal_anim()
