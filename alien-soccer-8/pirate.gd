extends alien

var ult_balls_out = false
var balls_out = false

var opp_slowed = false
var ult_slowed = false
var slow_timer = 0
var slow_amount

var cannons_load = preload("res://cannons.tscn")
var cannons

var down_arrow_load = preload("res://down_arrow.tscn")
var down_arrow

func _ability():
	if not balls_out and not ult_balls_out and cooldown <= 0:
		cannons.fire()
		balls_out = true

func _ultimate():
	if not balls_out and not ult_balls_out and charge >= charge_max:
		cannons.fire_ult(opponent.position)
		ult_balls_out = true
		charge = 0

func _ability_cooldown(delta):
	if charge < charge_max and not ult_balls_out:
		charge += delta
	
	if cooldown > 0:
		cooldown -= 1 * delta
	
	if slow_timer > 0:
		slow_timer -= delta
		down_arrow.visible = true
		down_arrow.position = opponent.position
		down_arrow.position.y += (opponent.base_scale * -32) - 12
	elif ult_slowed:
		slow_timer = 0
		ult_slowed = false
		opp_slowed = false
		opponent.update_move_speed(opponent.move_speed / 0.5)
		down_arrow.visible = false
	elif opp_slowed:
		slow_timer = 0
		ult_slowed = false
		opp_slowed = false
		opponent.update_move_speed(opponent.move_speed / 0.7)
		down_arrow.visible = false

func on_ready():
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	down_arrow = down_arrow_load.instantiate()
	down_arrow.visible = false
	add_sibling(down_arrow)
	
	cannons = cannons_load.instantiate()
	if player == 2:
		cannons.position.x = 1152
		cannons.scale.x *= -1
	cannons.camera = camera
	cannons.user = self
	add_sibling(cannons)
	
	base_scale = 1
	
	charge_max = 900
	
	update_move_speed(move_speed * 0.8, speed_damp)
