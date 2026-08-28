extends Node2D

@onready var arrows = [%"3", %"4", %"1", %"2"]
var user

func _ready():
	print(arrows)

func _physics_process(delta):
	user.charges = min(4, user.charges)
	
	%AnimatedSprite2D.animation = str(user.charges)
	
