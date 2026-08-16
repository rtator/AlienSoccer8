extends alien

var ult_mode = false
var speed_mult = 2
var damp_mult = 1.5
var size_mult = 1.3 

@onready var shockwave = %basic_shockwave

func _ability():
	if not shockwave.on and cooldown <= 0:
		shockwave.fire()

func _ultimate():
	if cooldown <= 0 and ult_dur <= 0 and charge >= charge_max:
		if not ult_mode:
			update_move_speed(move_speed * speed_mult, speed_damp * damp_mult)
			update_scale(base_scale * size_mult)
			ult_mode = true
			ult_dur = 200
			
			charge = 0
	
func _ability_cooldown(delta):
	#print(%AnimatedSprite2D.global_scale)
	#print(base_scale)
	if charge < charge_max and not ult_mode:
		charge += delta
	
	if ult_dur > 0:
		ult_dur -= 1 * delta
	elif ult_mode:
		update_move_speed(move_speed / speed_mult, speed_damp / damp_mult)
		update_scale(base_scale / size_mult)
		
		ult_mode = false
		cooldown == 100
	
	if cooldown > 0:
		cooldown -= 1 * delta
		print(cooldown)
	
	if duration > 0:
		duration -= 1 * delta

func on_ready():
	shockwave.user = self
	
	if online:
		set_multiplayer_authority(int(name))
		#%MultiplayerSynchronizer.set_multiplayer_authority(int(name))
		print("name is " + name + ". authority is " + str(is_multiplayer_authority()))
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	base_scale = 1
	
	charge_max = 500
	#charge_bar = %p1Charge
	
	#set_player(1)
	update_move_speed(move_speed, speed_damp)
