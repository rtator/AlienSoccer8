extends CanvasLayer

var user

func _ready():
	if user.player == 1:
		%p1Charge.visible = true
	if user.player == 2:
		%p2Charge.visible = true

func _physics_process(delta):
	%p1Charge.value = user.health
	%p2Charge.value = user.health
