extends Node2D

const player_objects = {
	"basic": preload("res://basicAlien.tscn"),
	"speedy": preload("res://speedyAlien.tscn"),
	"scaler": preload("res://scalerAlien.tscn"),
	"jumper": preload("res://jumperAlien.tscn"),
	"launcher": preload("res://launcherAlien.tscn"),
	"freezer": preload("res://freezerAlien.tscn"),
	"clock": preload("res://clockAlien.tscn"),
	"trickster": preload("res://tricksterAlien.tscn"),
	"gambler": preload("res://gamblerAlien.tscn"),
	"wrangler": preload("res://wranglerAlien.tscn"),
	"target": preload("res://targetAlien.tscn"),
	"twins": preload("res://twinsAlien.tscn"),
	"warper": preload("res://warperAlien.tscn"),
	"mosquito": preload("res://mosquitoAlien.tscn"),
	"spectre": preload("res://spectreAlien.tscn"),
	"cloaker": preload("res://cloakerAlien.tscn"),
	"pirate": preload("res://pirateAlien.tscn"),
	"mothership": preload("res://mothershipAlien.tscn"),
	"warden": preload("res://wardenAlien.tscn"),
	"nuclear": preload("res://nuclearAlien.tscn"),
	"breezer": preload("res://breezerAlien.tscn"),
	"decayed": preload("res://decayedAlien.tscn"),
}

var p1
var p2

var paused = false

var pause_screen_load = preload("res://pauseScreen.tscn")
var pause_screen

@onready var canvas_layer = %CanvasLayer
@onready var camera = %Camera2D
@onready var statue = %inverted_statue
@onready var round_time_label = %time_left
@onready var border = %game_border
@onready var shop = %shop_screen
@onready var ball_eater = %ball_eater

var ball_load = preload("res://ball.tscn")
var balls = []

var base_ball_x = 288
var ball_x_add = 576

var ball_dir = 1
var base_ball_speed_mult = 1.0

var round_ending = false
var round_over = false
var eaten_balls = 0

var othersider_load = preload("res://pve/scenes/trinkets/othersider.tscn")
var othersider_x = 500

var othersiders = []

# things at the start 
#region New Code Region
func _ready():
	PveSave.trinkets = []
	
	PveSave.round = 0
	
	if GlobalSave.one_player:
		%inverted_statue.set_collision_layer_value(1, false)
		%inverted_statue.set_collision_mask_value(1, false)
		%inverted_statue.modulate.a = 0.8
		
		base_ball_speed_mult = 0.75
	
	shop.over.connect(restart_round)
	
	ball_eater.eaten.connect(ball_eaten)
	
	%time_left.new_wave.connect(spawn_wave)
	
	GlobalSave.playing_pve = true
	
	statue.die.connect(statue_die)
	spawn_player()
	
	spawn_balls()
	
	spawn_pause_screen()

func spawn_player():
		p1 = player_objects[GlobalSave.p1Char].instantiate()
		p1.balls = balls
		p1.camera = %Camera2D
		p1.position = Vector2(456, 342)
		p1.set_player(2)
		p1.swap_player = true
		p1.charge_bar = %p1Charge
		p1.cooldown_bar = %p1Cooldown
		p1.skin = GlobalSave.p1Skin
		
		if not GlobalSave.one_player:
			p2 = player_objects[GlobalSave.p2Char].instantiate()
			p2.balls = balls
			p2.camera = %Camera2D
			p2.position = Vector2(696, 342)
			p2.set_player(1)
			p2.swap_player = true
			p2.charge_bar = %p2Charge
			p2.cooldown_bar = %p2Cooldown
			p2.skin = GlobalSave.p2Skin
		else:
			%p2Charge.visible = false
			%p2Cooldown.visible = false
			
			%p2UltLabel.visible = false
			%p2CooldownLabel.visible = false
			
			%GridContainer.columns = 1
		
		
		
		
		#p1.opponent = [p2]
		p1.character = GlobalSave.p1Char
		#p2.opponent = [p1]
		if not GlobalSave.one_player:
			p2.character = GlobalSave.p2Char
		
		PveSave.p1 = p1
		if not GlobalSave.one_player:
			PveSave.p2 = p2
		
		add_child(p1)
		if not GlobalSave.one_player:
			add_child(p2)

func spawn_balls():
	print("ball #: ", PveSave.ball_number)
	if PveSave.ball_number <= 2:
		var ball_x = base_ball_x
		for i in range(PveSave.ball_number):
			var ball = ball_load.instantiate()
			ball.speed_add = 0
			ball.ball_speed *= base_ball_speed_mult
			ball.camera = %Camera2D
			ball.position.y = 324
			ball.position.x = ball_x
			var rand_vec = Vector2(randf_range(-1, 1), randf_range(-1, 1))
			ball.linear_velocity = rand_vec
			add_child(ball)
			balls.append(ball)
			
			ball_x += ball_x_add
	elif PveSave.ball_number <= 4:
		pass
	elif PveSave.ball_number <= 6:
		pass

func spawn_pause_screen():
	pause_screen = pause_screen_load.instantiate()
	pause_screen.visible = false
	pause_screen.level = self
	canvas_layer.add_child(pause_screen)
#endregion

# pause stuff
#region New Code Region
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		#trying_to_pause = true
		pause()

func unpause():
	get_tree().paused = false
	#Engine.time_scale = 1
	paused = false
	pause_screen.visible = false

func pause():
		if not paused:
			get_tree().paused = true
			#Engine.time_scale = 0
			paused = true
			pause_screen.visible = true
#endregion

# wave / round stuff and the statue death
#region New Code Region
func spawn_othersiders(amount : int = 1):
	for i in range(amount):
		var rand_x = (randi_range(0,1) * 2) - 1
		var x = othersider_x * rand_x
		var y = randf_range(0,648)
		
		var pos = Vector2(x,y).normalized() * othersider_x
		pos = pos + Vector2(576, 324) 
		
		var othersider = othersider_load.instantiate()
		othersider.position = pos
		othersider.die.connect(othersider_die)
		add_child(othersider)
		othersiders.append(othersider)
		
		p1.opponent = othersiders
		if not GlobalSave.one_player:
			p2.opponent = othersiders

func othersider_die(othersider):
	othersiders.erase(othersider)
	p1.opponent = othersiders
	if not GlobalSave.one_player:
		p2.opponent = othersiders

func statue_die():
	camera.zoom_center_won()

func spawn_wave():
	camera.shake(100)
	
	var ball = ball_load.instantiate()
	ball.speed_add = 0
	ball.ball_speed = balls[0].ball_speed
	ball.camera = %Camera2D
	ball.position.y = 324
	ball.position.x = 576 + (base_ball_x * ball_dir)
	var rand_vec = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	ball.linear_velocity = rand_vec
	add_child(ball)
	balls.append(ball)
	
	p1.balls = balls
	if not GlobalSave.one_player:
		p2.balls = balls
	
	ball_dir *= -1
	
	spawn_othersiders()

func ball_eaten(ball):
	if round_ending:
		eaten_balls += 1
		print("eat number: ", eaten_balls, "ball_number: ", len(balls))
		print("balls: ", balls)
		if eaten_balls >= len(balls):
			end_round()

func end_round():
	p1.linear_velocity.y += 10000
	if not GlobalSave.one_player:
		p2.linear_velocity.y += 10000
	
	round_over = true
	shop.open_shop()
	round_time_label.visible = false

func restart_round():
	PveSave.round += 1
	
	for trinket in PveSave.trinkets:
		if "on_start" in trinket:
			trinket.on_start.call()
	
	border.set_collision_layer_value(1, true)
	border.set_collision_mask_value(1, true)
	
	round_ending = false
	round_over = false
	round_time_label.restart()
	
	eaten_balls = 0
	
	for ball in balls:
		ball.linear_velocity = Vector2(randf_range(-1,1), randf_range(-1,1))
		ball.enable_collision()
	
	if not GlobalSave.one_player:
		spawn_othersiders(1)

func _on_time_left_timer_timeout():
	round_ending = true
	
	border.set_collision_layer_value(1, false)
	border.set_collision_mask_value(1, false)
#endregion

# proccess
#region New Code Region
func _physics_process(delta):
	if GlobalSave.one_player:
		%inverted_statue.modulate.a = 0.8
#endregion
