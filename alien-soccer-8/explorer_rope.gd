extends Line2D

@export var parent : Node2D
@export var hook : Node2D

var active = false

func _ready():
	print("ready")


func _physics_process(delta):
	global_position = Vector2(0,0)
	clear_points()
	if active:
		if parent != null:
			add_point(parent.global_position)# - global_position)
		if hook != null:
			add_point(hook.global_position)# - global_position)
