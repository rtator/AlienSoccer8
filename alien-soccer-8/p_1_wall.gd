extends StaticBody2D

var score = 0
var score_board

@onready var camera = %Camera2D

func _ready():
	score_board = %p2Score

func add_score():
	score += 1 
	score_board.text = str(score)
	
	camera.zoom_left()
	
	return Vector2(288, 324)
