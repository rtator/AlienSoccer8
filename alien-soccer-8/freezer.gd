extends alien


var block_amount = 0
var max_block_amount = 4

var block_load = preload("res://ice_block.tscn")

var overlay_load = preload("res://ice_block_overlay.tscn")
var overlays = []

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
		cooldown = 500

func _ultimate():
	if charge >= charge_max and not opp_slipping and ult_dur <= 0:
		for opp in opponent:
			opp.add_speed_mult(move_mult, 175, slip_mult)
		
		for overlay in overlays:
			overlay.visible = true
		
		charge = 0
		
		ult_dur = 175
		opp_slipping = true

func _ability_cooldown(delta):
	if cooldown > 0 and not block_amount >= max_block_amount:
		cooldown -= delta
	
	if ult_dur > 0:
		ult_dur -= delta
	elif opp_slipping:
		opp_slipping = false
		
		for overlay in overlays:
			overlay.visible = false
	
	if charge < charge_max and not opp_slipping:
		charge += delta

func on_ready():
	for opp in opponent:
		var overlay = overlay_load.instantiate()
		overlay.position = Vector2(0,0)
		overlay.z_index = opp.z_index + 1
		overlay.visible = false
		opp.add_child(overlay)
		
		overlays.append(overlay)
	
	base_scale = 0.8
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
		%AnimatedSprite2D.play()
	
	squish *= 2
	stretch *= 2
	
	charge_max = 500
	
	update_move_speed(move_speed * 0.3, speed_damp * 0.16)
