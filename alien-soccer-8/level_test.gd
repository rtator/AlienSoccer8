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
}

var p1
var p2

var paused = false

var pause_screen_load = preload("res://pauseScreen.tscn")
var pause_screen

@onready var canvas_layer = %CanvasLayer

func _ready():
	p1 = player_objects[GlobalSave.p1Char].instantiate()
	p1.ball = %ball
	p1.camera = %Camera2D
	if GlobalSave.p1IsBot:
		p1.is_bot = true
	p1.position = Vector2(288, 342)
	p1.set_player(1)
	p1.charge_bar = %p1Charge
	p1.cooldown_bar = %p1Cooldown
	p1.skin = GlobalSave.p1Skin
	
	if GlobalSave.p1Char == "target":
		%p2Wall.collision_layer = 0
		%p2Wall.collision_mask = 0
		p1.score_board = %p1Score
	
	p2 = player_objects[GlobalSave.p2Char].instantiate()
	p2.ball = %ball
	p2.camera = %Camera2D
	if GlobalSave.p2IsBot:
		p2.is_bot = true
	p2.position = Vector2(864, 342)
	p2.set_player(2)
	p2.charge_bar = %p2Charge
	p2.cooldown_bar = %p2Cooldown
	p2.skin = GlobalSave.p2Skin
	
	if GlobalSave.p2Char == "target":
		%p1Wall.collision_layer = 0
		%p1Wall.collision_mask = 0
		p2.score_board = %p2Score
	
	p1.opponent = p2
	p1.character = GlobalSave.p1Char
	p2.opponent = p1
	p2.character = GlobalSave.p2Char
	
	
	add_child(p1)
	add_child(p2)
	
	pause_screen = pause_screen_load.instantiate()
	pause_screen.visible = false
	pause_screen.level = self
	canvas_layer.add_child(pause_screen)

func unpause():
	Engine.time_scale = 1
	paused = false
	pause_screen.visible = false

func _unhandled_input(event):
	if event.is_action_pressed("pause") :
		if not paused:
			Engine.time_scale = 0
			paused = true
			pause_screen.visible = true
