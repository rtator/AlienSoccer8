extends alien

var bomb_out = false
var bomb
var bomb_load = preload("res://smoke_bomb.tscn")
var bomb_speed = 1000

var ult_bomb_out = false

func _ability():
	if cooldown <= 0 and not bomb_out:
		bomb_out = true
		bomb = bomb_load.instantiate()
		var offsetX = 576 - position.x
		print(position.x)
		var throw_vec = Vector2(offsetX, 0).normalized()
		bomb.position = position + throw_vec * 50
		bomb.linear_velocity = throw_vec * bomb_speed
		bomb.user = self
		add_sibling(bomb)


func _ultimate():
	if charge >= charge_max and not ult_bomb_out:
		ult_bomb_out = true
		bomb = bomb_load.instantiate()
		var offsetX = 576 - position.x
		print(position.x)
		var throw_vec = Vector2(offsetX, 0).normalized()
		bomb.position = position + throw_vec * 50
		bomb.linear_velocity = throw_vec * bomb_speed
		bomb.user = self
		bomb.is_ult = true
		add_sibling(bomb)
		charge = 0

func _ability_cooldown(delta):
	#print(%AnimatedSprite2D.global_scale)
	#print(base_scale)
	if charge < charge_max and not ult_bomb_out:
		charge += delta
	
	if ult_dur > 0:
		ult_dur -= 1 * delta
	
	if cooldown > 0:
		cooldown -= 1 * delta
		print(cooldown)

func on_ready():
	base_scale = 1.2
	
	charge_max = 600
	
	update_move_speed(move_speed * 0.8, speed_damp)
