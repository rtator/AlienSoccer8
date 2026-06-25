extends alien


var block_amount = 0
var max_block_amount = 4

var block_load = preload("res://ice_block.tscn")

var opp_slipping = false
var slip_mult = 0.2
var move_mult = 0.3

func _ability():
	if cooldown <= 0 and block_amount < max_block_amount:
		var block = block_load.instantiate()
		block.position = position
		block.user = self
		block.skin = skin
		block_amount += 1
		get_parent().add_child(block)
		cooldown = 200

func _ultimate():
	if charge >= charge_max and not opp_slipping and ult_dur <= 0:
		opponent.update_move_speed(opponent.move_speed * move_mult, opponent.speed_damp * slip_mult)
		
		opponent.sprite.modulate  = Color(1, 1, 6)
		
		charge = 0
		
		ult_dur = 175
		opp_slipping = true

func _ability_cooldown(delta):
	if cooldown > 0:
		cooldown -= delta
	
	if ult_dur > 0:
		ult_dur -= delta
	elif opp_slipping:
		opp_slipping = false
		opponent.sprite.modulate  = Color.WHITE
		opponent.update_move_speed(opponent.move_speed / move_mult, opponent.speed_damp / slip_mult)
	
	if charge < charge_max and not opp_slipping:
		charge += delta

func on_ready():
	base_scale = 0.8
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
		%AnimatedSprite2D.play()
	
	squish *= 2
	stretch *= 2
	
	charge_max = 500
	
	update_move_speed(move_speed * 0.3, speed_damp * 0.16)
