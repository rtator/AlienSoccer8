extends alien

var together = true
var sep_dist = 70
var sep_speed = 10

@onready var hitbox2 = %CollisionShape2D2

@onready var twin_sprite1 = %AnimatedSprite2D2
@onready var twin_sprite2 = %AnimatedSprite2D3

var ulting = false

func _ability():
	if cooldown <= 0:
		cooldown = 100
		if together:
			together = false
		else:
			together = true

func _ultimate():
	if not ulting and ult_dur <= 0 and charge >= charge_max:
		ulting = true
		ult_dur = 500
		charge = 0
		twin_sprite1.animation = "ult"
		twin_sprite2.animation = "ult"
		
		if skin != 0:
			%AnimatedSprite2D2.animation = "ult_" + str(skin)
			%AnimatedSprite2D3.animation = "ult_" + str(skin)

func _ability_cooldown(delta):
	if cooldown > 0:
		cooldown -= delta
	
	if ult_dur > 0:
		ult_dur -= delta
	elif ulting:
		ulting = false
		twin_sprite1.animation = "default"
		twin_sprite2.animation = "default"
		
		if skin != 0:
			%AnimatedSprite2D2.animation = "default_" + str(skin)
			%AnimatedSprite2D3.animation = "default_" + str(skin)
	
	if charge < charge_max:
		charge += delta
	
	if together:
		hitbox.position += (Vector2(0, 16) - hitbox.position).normalized() * sep_speed * delta
		if hitbox.position.y - 16 <= 10:
			hitbox.position = Vector2(0,16)
		
		hitbox2.position += (Vector2(0, -16) - hitbox2.position).normalized() * sep_speed * delta
		if hitbox2.position.y + 16 >= -10:
			hitbox2.position = Vector2(0,-16)
	else:
		hitbox.position += (Vector2(0, sep_dist) - hitbox.position).normalized() * sep_speed * delta
		if hitbox.position.y - sep_dist >= -10:
			hitbox.position = Vector2(0, sep_dist)
		hitbox2.position += (Vector2(0, -sep_dist) - hitbox2.position).normalized() * sep_speed * delta
		if hitbox2.position.y + sep_dist <= 10:
			hitbox2.position = Vector2(0, -sep_dist)
	
	twin_sprite1.position = hitbox.position
	twin_sprite2.position = hitbox2.position
	

func on_ready():
	base_scale = 1
	
	if skin != 0:
		%AnimatedSprite2D2.animation = "default_" + str(skin)
		%AnimatedSprite2D3.animation = "default_" + str(skin)
		%AnimatedSprite2D3.rotation = 0
		%AnimatedSprite2D2.scale = Vector2(0.16, 0.16)
		%AnimatedSprite2D3.scale = Vector2(0.16, 0.16)
	
	stretch = 1000
	squish = 1000
	
	charge_max = 300
	update_move_speed(move_speed, speed_damp)

func _on_body_entered(body):
	if ulting:
		if body == ball:
			ult_dur = 0
			ball.reseting = true
			var pos_x
			if player == 1:
				pos_x = position.x + 32
			else:
				pos_x = position.x - 32
			var new_pos = ball.position
			var reflect_vec = Vector2(ball.position.x, position.y).normalized()
			new_pos = new_pos.reflect(reflect_vec)
			new_pos.x = pos_x
			ball.new_pos = new_pos
