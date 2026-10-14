extends CanvasLayer

var user

func _ready():
	if (user.player == 1 and not user.swap_player) or (user.player == 2 and user.swap_player):
		%p1Charge.visible = true
	else:
		%p2Charge.visible = true

func _physics_process(delta):
	%p1Charge.value = user.health
	%p2Charge.value = user.health
