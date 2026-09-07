extends RigidBody2D

var user


func _ready():
	add_collision_exception_with(user)
	add_collision_exception_with(user.ball)

func _on_timer_timeout():
	queue_free()

func spawn_bombs():
	
