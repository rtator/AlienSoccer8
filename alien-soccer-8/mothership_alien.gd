extends alien

var ore_load = preload("res://ore.tscn")
var ore
var touching_ore = false

var drone_load = preload("res://drone.tscn")

func _ability():
	if cooldown <= 0 and touching_ore:
		charge += 5
		cooldown = 10

func _ultimate():
	if charge >= charge_max:
		var drone = drone_load.instantiate()
		drone.ball = ball
		drone.position = position
		drone.z_index = -0.5
		add_sibling(drone)
		
		charge = 0

func _ability_cooldown(delta):
	if (player == 1 and Input.is_action_pressed("p1_ability")) or (player == 2 and Input.is_action_pressed("p2_ability")):
		_ability()
		print("pressed")
	
	if cooldown > 0:
		cooldown -= 1 * delta
	
	if duration > 0:
		duration -= 1 * delta

func on_ready():
	ore = ore_load.instantiate()
	if player == 1:
		ore.position = Vector2(288, 324)
	else:
		ore.position = Vector2(864, 324)
	add_sibling(ore)
	print("z ",z_index)
	ore.z_index = -1
		
	
	
	#if skin != 0:
		#%AnimatedSprite2D.animation = "default_" + str(skin)
	base_scale = 1.1
	
	charge_max = 150
	update_move_speed(move_speed * 0.5, speed_damp * 0.6)
