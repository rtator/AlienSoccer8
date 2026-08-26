extends Node2D

@onready var children = get_children()

@onready var animation_player = %AnimationPlayer

func restart():
	if animation_player != null:
		animation_player.current_animation = "restart"
	
	#for child in children:
		#child.restart()
		
