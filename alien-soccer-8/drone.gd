extends RigidBody2D

var ball

var life = 3
var dir = 1

var death_load = preload("res://drone_die.tscn")

func _ready():
	linear_velocity.y = 300

func _physics_process(delta):
	linear_velocity.x = 0
	linear_velocity = linear_velocity.normalized() * 300
	
	if life <= 0:
		queue_free()
		var deadvfx = death_load.instantiate()
		deadvfx.position = position
		deadvfx.emitting = true 
		add_sibling(deadvfx)

func _on_body_entered(body):
	if body == ball:
		life -= 1
		print("life", life)
	else:
		%sprite.flip_v = not %sprite.flip_v
		dir *= -1
		linear_velocity.y = dir * 300


func _on_timer_timeout():
	life = -5
