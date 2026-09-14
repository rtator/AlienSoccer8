extends Area2D

var user

func _ready():
	%cluster_explosion_particles.emitting = true

func _on_body_entered(body):
	if body.has_method("add_speed_mult"):
		user.hit_opp_cluster(body,position)

func _on_cluster_explosion_particles_finished():
	queue_free()
