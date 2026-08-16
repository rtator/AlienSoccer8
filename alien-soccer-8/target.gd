extends alien

var goal_loaded = preload("res://target_wall.tscn")
var goal
var score_board

var arrow_loaded = preload("res://arrow.tscn")
var arrow
var arrow_speed = 900
var arrow_hit = false
var shooting = false

var ulting = false

var sped_up = false
var speed_timer = 0
func _ability():
	if not shooting and cooldown <= 0:
		shooting = true
		arrow = arrow_loaded.instantiate()
		arrow.player = player
		arrow.shooter = self
		arrow.skin = skin
		var arrow_vec = Vector2(0, 0)
		if player == 1:
			arrow.position = Vector2(randf_range(0, 576), 30)
		else:
			arrow.position = Vector2(randf_range(576, 1120), 30)
		arrow.linear_velocity = arrow_vec
		add_sibling(arrow)

func _ultimate():
	if charge >= charge_max && not ulting:
		ulting = true
		charge = 0
		goal.ult()
		camera.shake(7.5)

func _ability_cooldown(delta):
	if charge < charge_max and not ulting:
		charge += delta
	
	if goal.ult_ended:
		ulting = false
		goal.ult_ended = false
	
	if cooldown > 0:
		shooting = false
		cooldown -= delta
	
	if sped_up and speed_timer > 0:
		speed_timer -= delta
	elif sped_up:
		update_move_speed(move_speed / 1.5, speed_damp)
		sped_up = false
		print("slowed")

func on_ready():
	goal = goal_loaded.instantiate()
	goal.score_board = score_board
	goal.camera = camera
	goal.user = self
	if player == 1:
		goal.position.x = 1152
	goal.player = player
	add_sibling(goal)
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	base_scale = 0.8
	
	charge_max = 700
	
	update_move_speed(move_speed * 0.8, speed_damp)


func on_hit() :
	if not sped_up:
		sped_up = true
		speed_timer = 200
		update_move_speed(move_speed * 1.5, speed_damp)
