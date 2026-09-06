extends StaticBody2D

var p1
var p2

var player
var score_board
var goal

var user

var camera

var ult_ended = false

var two_times_scored = false

func _ready():
	p1 = %p1
	p2 = %p2
	goal = %goal
	goal.scored.connect(score_2x)
	
	goal.player = player
	
	if (player == 1):
		p1.disabled = true
		goal.score_board = score_board
	else:
		p2.disabled = true
		goal.score_board = score_board
		print(goal.score_board)

func score_2x(new_score):
	goal.score = new_score
	
	two_times_scored = true
	%score_timer.start()

func _on_score_timer_timeout():
	two_times_scored = false

func ult():
	%Timer.start()
	goal.scale.y = 2
	print(user.position.y)
	goal.position.y = user.position.y - 324

func _on_timer_timeout():
	goal.scale.y = 1
	goal.position.y = 0
	ult_ended = true

func add_score():
	if not two_times_scored:
		goal.score += 1
		score_board.text = str(goal.score)
		
		if goal.score >= GlobalSave.winMax:
			if player == 2:
				GlobalSave.winner = 2
				
				camera.zoom_left_won()
				
				return Vector2(288, 324)
			else:
				GlobalSave.winner = 1
				
				camera.zoom_right_won()
				
				return Vector2(864, 324)
		elif player == 2:
			camera.zoom_left()
			return Vector2(288, 324)
		else:
			camera.zoom_right()
			return Vector2(864, 324)
