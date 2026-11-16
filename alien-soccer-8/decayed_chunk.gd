extends Area2D

var user
var grabable = false

var glowing = false

var explosion_load = preload("res://decayed_explosion.tscn")

func _ready():
	rotation = randf_range(0,2 * PI)
	if randi_range(0,1) == 1:
		scale.x *= -1

func _physics_process(delta):
	if glowing:
		$AnimatedSprite2D.frame = 1
	else:
		$AnimatedSprite2D.frame = 0


func _on_body_entered(body):
	if body == user: 
		if grabable and not body.rushing:
			body.heal_anim()
			body.health += body.chunk_heal
			body.last_chunk_health = body.health
			body.chunks.erase(self)
			queue_free()

func _on_timer_timeout():
	grabable = true
	modulate = Color(1,1,1,1)

func explode():
	var explosion = explosion_load.instantiate()
	explosion.position = position
	explosion.user = user
	add_sibling(explosion)
	user.chunks.erase(self)
	queue_free()
