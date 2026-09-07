extends Area2D

var user

func _ready():
	%cluster_explosion_particles.emitting = true

func _on_body_entered(body):
	if body == user.opponent:
		user.hit_opp_cluster(position)

func _on_cluster_explosion_particles_finished():
	queue_free()
