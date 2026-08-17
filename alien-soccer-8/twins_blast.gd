extends RigidBody2D

var alpha = 1

var new_scale = Vector2(0.8,0.8)

func _physics_process(delta):
	scale = new_scale
	new_scale *= 1.1

	print(scale)
	
	modulate = Color(1,1,1,alpha)
	alpha -= 0.05
	if alpha <= 0:
		queue_free()


func _on_body_entered(body):
	if "temp_speed" in body:
		body.temp_speed = 400
