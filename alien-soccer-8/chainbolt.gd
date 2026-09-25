extends Area2D

var user
var dir

var speed = 30

func _physics_process(delta):
	position.x += speed * dir

func _on_body_entered(body):
	if "cooldown" in body and body != user:
		user.chain_hit = true
		user.hit_body = body
	
	if not "ball_speed" in body and body != user:
		user.chain_dead = true
		queue_free()
