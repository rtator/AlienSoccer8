extends StaticBody2D

var score = 0
var score_board

func _ready():
	score_board = %p1Score

func add_score():
	print(score)
	score += 1 
	score_board.text = str(score)
	
	#ball.position = Vector2(864, 324)
	#ball.linear_velocity = Vector2(0,0)
	#ball.ball_speed = ball.ball_base_speed
	
	return Vector2(864, 324)
