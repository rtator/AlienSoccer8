extends Node2D

@onready var arrows = [%"3", %"4", %"1", %"2"]
var user

func _ready():
	print(arrows)

func _physics_process(delta):
	user.charges = min(4, user.charges)
	
	for i in range(4):
		arrows[i].visible = false
	
	for charge in range(user.charges):
		arrows[charge].visible = true
	
	
