extends CanvasLayer

var user

var bar

@onready var batteries = [%"1",%"2",%"3",%"4",%"5",%"6",%"7",%"8",%"9",%"10"]

@onready var bar1 = %bar1
@onready var bar2 = %bar2
@onready var hidden = %hidden

@onready var p1 = %p1
@onready var p2 = %p2
var icon

func _ready():
	if user.player == 1:
		icon = p1
		bar = bar1
	else:
		icon = p2
		bar = bar2
	
	icon.visible = true

func _physics_process(delta):
	icon.frame = user.batteries
	
	#for battery in batteries:
		#battery.reparent(hidden)
	#
	#for battery in range(user.batteries):
		#batteries[battery].reparent(bar)
