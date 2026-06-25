extends alien

var swarm_load = preload("res://swarm.tscn")

var swarm_speed = 500

var swarm_size_ability = 0
var max_swarm_ability_size = 10

var swarm_size_ult = 0
var max_swarm_ult_size = 20

var spawning_swarm_ability = false
var spawning_swarm_ult = false

func _ability():
	if cooldown <= 0:
		spawning_swarm_ability = true
		cooldown = 200

func _ultimate():
	if charge >= charge_max:
		spawning_swarm_ult = true
		charge = 0

func _ability_cooldown(delta):
	if spawning_swarm_ability:
		if swarm_size_ability < max_swarm_ability_size:
			for i in range(randf_range(1,5)):
				if swarm_size_ability < max_swarm_ability_size:
					var swarm = swarm_load.instantiate()
					var offset = 576 - position.x
					var offsetVec = Vector2(offset, -abs(offset) * randf_range(0.5,0.7)).normalized()
					swarm.position = position + (offsetVec * 15)
					swarm.call_deferred("set_linear_velocity", offsetVec * swarm_speed)
					add_sibling(swarm)
					swarm_size_ability += 1
		else:
			spawning_swarm_ability = false
			swarm_size_ability = 0
	
	
	if spawning_swarm_ult:
		if swarm_size_ult < max_swarm_ult_size:
			for i in range(randf_range(1,10)):
				if swarm_size_ult < max_swarm_ult_size:
					var swarm = swarm_load.instantiate()
					var offset = 576 - position.x
					var offsetVec = Vector2(offset, -abs(offset) * randf_range(0.5,0.7)).normalized()
					swarm.position = position + (offsetVec * 50)
					swarm.call_deferred("set_linear_velocity", offsetVec * swarm_speed)
					add_sibling(swarm)
					swarm_size_ult += 1
		else:
			spawning_swarm_ult = false
			swarm_size_ult = 0
	
	if cooldown > 0:
		cooldown -= delta
	
	if charge <= charge_max:
		charge += delta

func on_ready():
	base_scale = 0.3
	
	if skin != 0:
		%AnimatedSprite2D.scale = Vector2(0.21, 0.21)
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	charge_max = 500
	
	update_move_speed(move_speed * 1.2, speed_damp)
