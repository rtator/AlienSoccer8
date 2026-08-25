extends CanvasLayer

func ability(player):
	if player == 1:
		%p1.restart()
		%p3.restart()
	else:
		%p2.restart()
		%p4.restart()
