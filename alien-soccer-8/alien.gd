extends alien

var ult_mode = false
var speed_mult = 2.5
var damp_mult = 1.7
var size_mult = 1

@onready var shockwave = %basic_shockwave
@onready var shield_sprite = %shieldSprite

func _ability():
	if not shockwave.on and cooldown <= 0 and not ult_mode:
		shockwave.fire()

func _ultimate():
	if ult_dur <= 0 and charge >= charge_max and not ult_mode:
		shield_sprite.visible = true
		hitbox.scale = Vector2(2,2)
		ult_mode = true
		
		charge = 0
	
func _ability_cooldown(delta):
	
	#print(%AnimatedSprite2D.global_scale)
	#print(base_scale)
	if charge < charge_max and not ult_mode and ult_dur <= 0:
		charge += delta
	
	if ult_dur > 1:
		ult_dur -= 1
	elif ult_dur > 0:
		modulate = Color(1,1,1)
		ult_dur -= 1
		update_move_speed(move_speed / speed_mult, speed_damp /damp_mult)
	
	if ult_mode:
		hitbox.scale = Vector2(2,2)
		#ult_mode = false
		#cooldown == 100
	
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


func _on_body_entered(body):
	if body == ball and ult_mode:
		print("hit")
		hitbox.scale = Vector2(1,1)
		ult_mode = false
		shield_sprite.visible = false
		ult_dur = 100
		modulate = Color(1.3,1.3,1.5)
		update_move_speed(move_speed * speed_mult, speed_damp * damp_mult)
