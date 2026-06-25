extends RigidBody2D

var user
var skin = 0
var is_block = true

func _on_body_entered(body):
	print("hit")
	if not "is_block" in body:
		print("not block")
		user.block_amount -= 1
		queue_free()

func _ready():
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
