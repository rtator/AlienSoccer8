extends alien

var lasso_load = preload("res://lasso.tscn")
var lasso
var ult_length = 300

var bomb_load = preload("res://bomb.tscn")
var bomb

var bomb_speed = 1000

var half_dur = 25

var lasso_out = false
func _ability():
	if cooldown <= 0 and duration <= 0 and not lasso_out:
		lasso_out = true
		duration = half_dur * 2
		lasso = lasso_load.instantiate()
		var offsetX = 576 - position.x
		var offsetVec = Vector2(offsetX, 0).normalized()
		lasso.position = offsetVec * 30
		if player == 2:
			lasso.scale.x *= -1
		lasso.user = self
		lasso.ball = ball
		add_child(lasso)

func _ultimate():
	if charge >= charge_max:
		bomb = bomb_load.instantiate()
		var offsetX = 576 - position.x
		print(position.x)
		var throw_vec = Vector2(offsetX, 0).normalized()
		bomb.position = position + throw_vec * 50
		bomb.linear_velocity = throw_vec * bomb_speed
		bomb.ball = ball
		bomb.user = self
		add_sibling(bomb)
		charge = 0

func _ability_cooldown(delta):
	if charge < charge_max:
		charge += delta
	
	if cooldown > 0:
		cooldown -= 1 * delta
	
	if duration > 0:
		duration -= delta
		if duration > half_dur:
			if player == 1:
				lasso.scale.x = ((half_dur - (duration - half_dur)) / half_dur) + 0.2
			else:
				lasso.scale.x = -((half_dur - (duration - half_dur)) / half_dur) - 0.2
			lasso.scale.y = (half_dur - (duration - half_dur)) / half_dur + 0.2
		else:
			if player == 1:
				lasso.scale.x = (duration / half_dur) + 0.2
			else:
				lasso.scale.x = -(duration / half_dur) - 0.2
			lasso.scale.y = duration / half_dur + 0.2
	elif lasso_out:
		cooldown = 150
		lasso_out = false
		if lasso.ball_grabbed:
			camera.shake(10)
		lasso.queue_free()

func on_ready():
	base_scale = 0.8
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	charge_max = 400
	
	update_move_speed(move_speed * 0.8, speed_damp)
