extends StaticBody2D

var score = 0
var score_board
var player

signal scored

func add_score():
	score += 2
	scored.emit(score)
	score_board.text = str(score)
	
	if score >= GlobalSave.winMax:
		if player == 2:
			GlobalSave.winner = 2
			
			get_parent().camera.zoom_left_won()
			
			return Vector2(288, 324)
		else:
			GlobalSave.winner = 1
			
			get_parent().camera.zoom_right_won()
			
			return Vector2(864, 324)
	if player == 2:
		get_parent().camera.zoom_left()
		return Vector2(288, 324)
	else:
		get_parent().camera.zoom_right()
		return Vector2(864, 324)
