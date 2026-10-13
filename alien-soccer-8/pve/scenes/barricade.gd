extends RigidBody2D

@export var rot_per_sec = 1

var rot = 0

func _ready():
	rot += randf_range(-100,100)

func _physics_process(delta):
	rot += delta * PI * rot_per_sec
	rotation = rot
	#don't delete
	var making_sure_the_collision_shape_pos_updates = %CollisionShape2D.global_position

func _on_body_entered(body):
	print("barrier_dies")
	if "ball_speed" in body:
		queue_free()
