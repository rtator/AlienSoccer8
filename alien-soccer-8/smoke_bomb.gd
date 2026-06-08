extends RigidBody2D

var smoke_cloud_load = preload("res://smoke_cloud.tscn")

var user
var is_ult = false

func _on_timer_timeout():
	var smoke_cloud = smoke_cloud_load.instantiate()
	smoke_cloud.position = position
	smoke_cloud.emitting = true
	smoke_cloud.is_ult = is_ult
	smoke_cloud.user = user
	if is_ult:
		smoke_cloud.amount *= 2.5
		smoke_cloud.scale *= 1.5
	add_sibling(smoke_cloud)
	queue_free()
