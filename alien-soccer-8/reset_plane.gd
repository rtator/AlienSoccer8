extends Area3D

@export var vec_to_set_to := Vector3(0,0,0)

func _on_body_entered(body):
	if body is RigidBody3D:
		body.position = vec_to_set_to
