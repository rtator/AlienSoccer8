extends StaticBody2D

var score = 0
var score_board

@onready var camera = %Camera2D

func _ready():
	score_board = %p1Score

func add_score():
	print(score)
	score += 1 
	score_board.text = str(score)
	
	if score >= GlobalSave.winMax:
		GlobalSave.winner = 1
		
		camera.zoom_right_won()
		
		return Vector2(864, 324)
	else:
		camera.zoom_right()
		
		return Vector2(864, 324)
