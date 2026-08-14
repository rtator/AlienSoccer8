extends StaticBody2D

var p1
var p2

var player
var score_board
var goal

var user

var camera

var ult_ended = false

func _ready():
	p1 = %p1
	p2 = %p2
	goal = %goal
	
	goal.player = player
	
	if (player == 1):
		p1.disabled = true
		goal.score_board = score_board
	else:
		p2.disabled = true
		goal.score_board = score_board
		print(goal.score_board)

func ult():
	%Timer.start()
	goal.scale.y = 2
	position.y = user.position.y

func _on_timer_timeout():
	goal.scale.y = 1
	goal.position.y = 324
	ult_ended = true

func add_score():
	goal.score += 1
	score_board.text = str(goal.score)
	if player == 2:
		camera.zoom_left()
		return Vector2(288, 324)
	else:
		camera.zoom_right()
		return Vector2(864, 324)
