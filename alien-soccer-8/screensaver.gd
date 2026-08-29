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
	"twins": preload("res://twinsAlien.tscn"),
	"warper": preload("res://warperAlien.tscn"),
	"mosquito": preload("res://mosquitoAlien.tscn"),
	"spectre": preload("res://spectreAlien.tscn"),
	"cloaker": preload("res://cloakerAlien.tscn"),
	"pirate": preload("res://pirateAlien.tscn"),
}

var p1
var p2


func _ready():
	GlobalSave.p1_bot_lv = 0
	GlobalSave.p2_bot_lv = 0
	
	var charKeys = player_objects.keys()
	p1 = player_objects[charKeys[randi_range(0, len(charKeys) - 1)]].instantiate()
	p1.ball = %ball
	p1.camera = %Camera2D
	p1.is_bot = true
	p1.position = Vector2(0, 342)
	p1.set_player(1)
	p1.skin = GlobalSave.p2Skin
	
	p2 = player_objects[charKeys[randi_range(0, len(charKeys) - 1)]].instantiate()
	p2.ball = %ball
	p2.camera = %Camera2D
	p2.is_bot = true
	p2.position = Vector2(1152, 342)
	p2.set_player(2)
	p2.skin = GlobalSave.p2Skin
	
	p2.opponent = p1
	p1.opponent = p2
	
	add_child(p1)
	add_child(p2)

func _physics_process(delta):
	%ball.ball_speed = 300
