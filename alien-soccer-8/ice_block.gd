extends RigidBody2D

var user
var is_block = true

func _on_body_entered(body):
	print("hit")
	if not "is_block" in body:
		print("not block")
		user.block_amount -= 1
		queue_free()
