extends RigidBody2D

var user
var directions = [Vector2(1,1),Vector2(1,-1), Vector2(-1,-1),Vector2(-1,1)]

var vfx_load = preload("res://cluster_explosion_particles.tscn")

func _ready():
	add_collision_exception_with(user)
	add_collision_exception_with(user.ball)

func _on_timer_timeout():
	var vfx = vfx_load.instantiate()
	vfx.position = position
	vfx.emitting = true
	add_sibling(vfx)
	
	user.camera.shake(50)
	
	spawn_bombs()
	queue_free()

func spawn_bombs():
	for i in range(4):
		var bomb = user.small_cluster_bomb_load.instantiate()
		
		bomb.position = position
		bomb.linear_velocity = user.small_cluster_bomb_speed * directions[i].normalized()
		bomb.user = user
		add_sibling(bomb)
