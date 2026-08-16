extends StaticBody2D

var score = 0
var score_board
var player

func add_score():
	score += 2
	score_board.text = str(score)
	if player == 2:
		get_parent().camera.zoom_left()
		return Vector2(288, 324)
	else:
		get_parent().camera.zoom_right()
		return Vector2(864, 324)
