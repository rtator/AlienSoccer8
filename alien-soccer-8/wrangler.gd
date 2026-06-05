extends alien

var lasso_load = preload("res://lasso.tscn")
var lasso
var ult_length = 300

var half_dur = 25

var lasso_out = false
func _ability():
	if cooldown <= 0 and duration <= 0:
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
#
#func _ultimate():
	#if charge >= charge_max:
		#charge = 0
		#banana = banana_load.instantiate()
		#var offsetX = 576 - position.x
		#print(position.x)
		#var offsetVec = Vector2(offsetX, offsetX).normalized()
		#banana.position = position + (offsetVec * 50)
		#banana.call_deferred("set_linear_velocity", offsetVec * bullet_speed)
		#banana.shooter = self
		#banana.ball = ball
		#add_sibling(banana)

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
		lasso_out = false
		lasso.queue_free()
	#
	#if slip_timer >= 0:
		#slip_timer -= 1
		#if slip_timer <= 20:
			#camera.shake(1)
	#elif opp_slipping:
		#opp_slipping = false
		#opponent.update_move_speed(abs(opponent.move_speed))

func on_ready():
	base_scale = 0.8
	
	charge_max = 400
	
	update_move_speed(move_speed * 0.6, speed_damp * 0.5)
