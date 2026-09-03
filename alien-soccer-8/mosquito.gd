extends alien

var swarm_load = preload("res://swarm.tscn")

var swarm_speed = 500

var swarm_size_ability = 0
var max_swarm_ability_size = 10

var swarm_size_ult = 0
var max_swarm_ult_size = 20

var spawning_swarm_ability = false
var spawning_swarm_ult = false

var swarm_ult_load = preload("res://swarm_ult.tscn")
var ult_swarm = []

var ball_scale = 1

var ultimate_duration = 200

var scale_time = 0
var scale_time_max = 200
var scaled = false

var original_scale = 0.3
var scale_mult = 1

var ulting = false

func _ability():
	if cooldown <= 0:
		spawning_swarm_ability = true
		cooldown = 250

func _ultimate():
	if charge >= charge_max:
		var angle = 1
		for i in range(3):
			
			var bug = swarm_ult_load.instantiate()
			
			bug.hit.connect(bug_hit)
			bug.rotation_degrees += angle
			
			angle += 120
			
			ult_swarm.append(bug)
			add_child(bug)
		
		ulting = true
		charge = 0
		ult_dur = ultimate_duration

func bug_hit(body):
	if body == ball:
		scaled = true
		scale_time = scale_time_max
		
		var bug = swarm_ult_load.instantiate()
		
		bug.hit.connect(bug_hit)
		
		ult_swarm.append(bug)
		add_child(bug)
		
		
		ball_scale *= 0.9
		
		ball.set_ball_scale(ball_scale)
		
		scale_mult += 0.1
		
		update_scale(original_scale * scale_mult)

func _ability_cooldown(delta):
	if spawning_swarm_ability:
		if swarm_size_ability < max_swarm_ability_size:
			for i in range(randf_range(1,5)):
				if swarm_size_ability < max_swarm_ability_size:
					var swarm = swarm_load.instantiate()
					var offset = 576 - position.x
					var offsetVec = Vector2(offset, -abs(offset) * randf_range(0.5,0.7)).normalized()
					swarm.position = position + (offsetVec * 10)
					swarm.call_deferred("set_linear_velocity", offsetVec * swarm_speed)
					add_sibling(swarm)
					swarm_size_ability += 1
		else:
			spawning_swarm_ability = false
			swarm_size_ability = 0
	
	
	#if spawning_swarm_ult:
		#if swarm_size_ult < max_swarm_ult_size:
			#for i in range(randf_range(1,10)):
				#if swarm_size_ult < max_swarm_ult_size:
					#var swarm = swarm_load.instantiate()
					#var offset = 576 - position.x
					#var offsetVec = Vector2(offset, -abs(offset) * randf_range(0.5,0.7)).normalized()
					#swarm.position = position + (offsetVec * 50)
					#swarm.call_deferred("set_linear_velocity", offsetVec * swarm_speed)
					#add_sibling(swarm)
					#swarm_size_ult += 1
		#else:
			#spawning_swarm_ult = false
			#swarm_size_ult = 0
	
	
	
	if cooldown > 0:
		cooldown -= delta
	
	if charge <= charge_max and ult_dur <= 0:
		charge += delta
	
	if ult_dur > 0:
		ult_dur -= delta
	elif ulting:
		ulting = false
		
		for i in ult_swarm:
			i.queue_free()
		ult_swarm.clear()
	
	if scale_time > 0:
		scale_time -= delta
	elif scaled:
		ball_scale = 1
		
		scale_mult = 1
		
		update_scale(original_scale)
		
		ball.set_ball_scale(1)
	
	

func on_ready():
	base_scale = original_scale
	
	if skin != 0:
		%AnimatedSprite2D.scale = Vector2(0.21, 0.21)
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	charge_max = 500
	
	update_move_speed(move_speed * 1.2, speed_damp)
