extends RigidBody2D

var user

var explosion_load = preload("res://cluster_explosion_area.tscn")

func _on_timer_timeout():
	var explosion = explosion_load.instantiate()
	explosion.position = position
	explosion.user = user
	add_sibling(explosion)
	
	user.camera.shake(50)
	
	queue_free()
