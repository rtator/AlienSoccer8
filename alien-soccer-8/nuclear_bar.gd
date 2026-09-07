extends CanvasLayer

var user

var bar

@onready var batteries = [%"1",%"2",%"3",%"4",%"5",%"6",%"7",%"8",%"9",%"10"]

@onready var bar1 = %bar1
@onready var bar2 = %bar2
@onready var hidden = %hidden

func _ready():
	if user.player == 1:
		bar = bar1
	else:
		bar = bar2

func _physics_process(delta):
	for battery in batteries:
		battery.reparent(hidden)
	
	for battery in range(user.batteries):
		batteries[battery].reparent(bar)
