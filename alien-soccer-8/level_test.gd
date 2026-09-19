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

var backgrounds = {
	"classic": preload("res://as8BG.png"),
	"realSoccer": preload("res://othersiderBG.png"),
	"jungle": preload("res://jungleBG.png"),
	"clones": preload("res://2Pas8BG.png"),
}

var map_obstacles = {
	"jungle": preload("res://moving_level_version.tscn"),
}

var p1
var p2

var paused = false

var pause_screen_load = preload("res://pauseScreen.tscn")
var pause_screen

@onready var canvas_layer = %CanvasLayer

func _ready():
	if backgrounds.has(GlobalSave.stage):
		%BG.texture = backgrounds[GlobalSave.stage]
	
	if map_obstacles.has(GlobalSave.stage):
		var obstacles = map_obstacles[GlobalSave.stage].instantiate()
		add_child(obstacles)
	
	
	if GlobalSave.stage == "realSoccer":
		%p1MiddleWall.set_collision_layer_value(4, false)
		%p2MiddleWall.set_collision_layer_value(8, false)
	
	p1 = player_objects[GlobalSave.p1Char].instantiate()
	p1.ball = %ball
	p1.camera = %Camera2D
	if GlobalSave.p1IsBot:
		p1.is_bot = true
	p1.position = Vector2(288, 342)
	if "clones" == GlobalSave.stage:
		p1.position = Vector2(288, 384)
	
	p1.set_player(1)
	p1.charge_bar = %p1Charge
	p1.cooldown_bar = %p1Cooldown
	p1.skin = GlobalSave.p1Skin
	
	if GlobalSave.p1Char == "target":
		%p2Wall.collision_layer = 0
		%p2Wall.collision_mask = 0
		p1.score_board = %p1Score
	
	var p1_clone
	if "clones" == GlobalSave.stage:
		p1_clone = player_objects[GlobalSave.p1Char].instantiate()
		p1_clone.ball = %ball
		p1_clone.camera = %Camera2D
		if GlobalSave.p1IsBot:
			p1_clone.is_bot = true
		p1_clone.position = Vector2(288, 264)
		
		p1_clone.set_player(1)
		p1_clone.charge_bar = %p1Charge
		p1_clone.cooldown_bar = %p1Cooldown
		p1_clone.skin = GlobalSave.p1Skin
	
	p2 = player_objects[GlobalSave.p2Char].instantiate()
	p2.ball = %ball
	p2.camera = %Camera2D
	if GlobalSave.p2IsBot:
		p2.is_bot = true
	p2.position = Vector2(864, 342)
	if "clones" == GlobalSave.stage:
		p2.position = Vector2(864, 384)
	p2.set_player(2)
	p2.charge_bar = %p2Charge
	p2.cooldown_bar = %p2Cooldown
	p2.skin = GlobalSave.p2Skin
	
	if GlobalSave.p2Char == "target":
		%p1Wall.collision_layer = 0
		%p1Wall.collision_mask = 0
		p2.score_board = %p2Score
	
	var p2_clone
	if "clones" == GlobalSave.stage:
		p2_clone = player_objects[GlobalSave.p2Char].instantiate()
		p2_clone.ball = %ball
		p2_clone.camera = %Camera2D
		if GlobalSave.p2IsBot:
			p2_clone.is_bot = true
		p2_clone.position = Vector2(864, 264)
		p2_clone.set_player(2)
		p2_clone.charge_bar = %p2Charge
		p2_clone.cooldown_bar = %p2Cooldown
		p2_clone.skin = GlobalSave.p2Skin
	
	
	
	p1.opponent = [p2]
	p1.character = GlobalSave.p1Char
	p2.opponent = [p1]
	p2.character = GlobalSave.p2Char
	
	if "clones" == GlobalSave.stage:
		p1.opponent = [p2, p2_clone]
		p1_clone.opponent = [p2, p2_clone]
		
		p1_clone.character = GlobalSave.p1Char
		
		p2.opponent = [p1, p1_clone]
		p2_clone.opponent = [p1, p1_clone]
		
		p2_clone.character = GlobalSave.p2Char
	
	add_child(p1)
	add_child(p2)
	
	if "clones" == GlobalSave.stage:
		add_child(p1_clone)
		add_child(p2_clone)
	
	pause_screen = pause_screen_load.instantiate()
	pause_screen.visible = false
	pause_screen.level = self
	canvas_layer.add_child(pause_screen)

func unpause():
	Engine.time_scale = 1
	paused = false
	pause_screen.visible = false

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if not paused:
			Engine.time_scale = 0
			paused = true
			pause_screen.visible = true
