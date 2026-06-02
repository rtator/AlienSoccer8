extends StaticBody2D

var score = 0
var score_board
var player

func add_score():
	score += 2
	score_board.text = str(score)
	if player == 2:
		return Vector2(288, 324)
	else:
		return Vector2(864, 324)
