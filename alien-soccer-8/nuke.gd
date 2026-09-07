extends RigidBody2D

var target := Vector2(0,0)
var user 

var speed = 30

var explosion_load = preload("res://nuke_explosion.tscn")
var explosion

@onready var crosshair = %NukeCrosshair

func _ready():
	speed = user.nuke_speed

func _physics_process(delta):
	linear_velocity = (target - position).normalized() * speed
	
	rotation = linear_velocity.angle()
	
	crosshair.global_position = target
	
	crosshair.global_rotation = 0
	
	user.camera.shake(1)
	
	if (target - position).length() < 10:
		explosion = explosion_load.instantiate()
		explosion.position = target
		explosion.user = user
		add_sibling(explosion)
		
		user.camera.shake(200)
		
		queue_free()
