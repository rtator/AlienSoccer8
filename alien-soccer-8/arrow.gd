extends RigidBody2D

var shooter
var player
var skin

var is_arrow = true

func _ready():
	
	if skin != 0:
		%AnimatedSprite2D.scale = Vector2(1.5, 1.5)
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	#if player == 1:
		#%AnimatedSprite2D.flip_h = true

func _on_body_entered(body):
	print("aaaaaaahhh I'm dying!")
	if body.has_method("stop_ball"):
		body.ball_speed -= 10
		body.stop_ball()
	if body == shooter:
		shooter.on_hit()
	if body.get("is_arrow") == null:
		shooter.cooldown = 200
		queue_free()
		
