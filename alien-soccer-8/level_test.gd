extends Node2D

const player_objects = {
	"basic": preload("res://basicAlien.tscn"),
	"speedy": preload("res://speedyAlien.tscn"),
	"scaler": preload("res://scalerAlien.tscn"),
	"jumper": preload("res://jumperAlien.tscn"),
}

var p1
var p2

func _ready():
	p1 = player_objects[GlobalSave.p1Char].instantiate()
	p1.ball = %ball
	if GlobalSave.p1IsBot:
		p1.is_bot = true
	p1.position = Vector2(288, 342)
	p1.set_player(1)
	p1.charge_bar = %p1Charge
	p1.cooldown_bar = %p1Cooldown
	
	p2 = player_objects[GlobalSave.p2Char].instantiate()
	p2.ball = %ball
	if GlobalSave.p2IsBot:
		p2.is_bot = true
	p2.position = Vector2(864, 342)
	p2.set_player(2)
	p2.charge_bar = %p2Charge
	p2.cooldown_bar = %p2Cooldown
	
	p1.opponent = p2
	p2.opponent = p1
	
	add_child(p1)
	add_child(p2)
