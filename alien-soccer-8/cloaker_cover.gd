extends CanvasLayer

func ability(player):
	if player == 1:
		%p2.restart()
		%p4.restart()
	else:
		%p1.restart()
		%p3.restart()
