extends alien

var goal_loaded = preload("res://target_wall.tscn")
var goal
var score_board

var arrow_loaded = preload("res://arrow.tscn")
var arrow
var arrow_speed = 1000
var arrow_hit = false
var shooting = false

var ulting = false

func _ability():
	if not shooting and cooldown <= 0:
		shooting = true
		arrow = arrow_loaded.instantiate()
		arrow.player = player
		arrow.shooter = self
		arrow.position = Vector2(576, position.y)
		var arrow_vec = Vector2(position.x - 576, 0).normalized() * arrow_speed
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
		cooldown -= 1

func on_ready():
	goal = goal_loaded.instantiate()
	goal.score_board = score_board
	if player == 1:
		goal.position.x = 1152
	goal.player = player
	add_sibling(goal)
	
	base_scale = 0.85
	
	charge_max = 500
	
	update_move_speed(move_speed * 0.85, speed_damp)
	
