extends RigidBody2D

var delete = false

var shooter
var skin = 0


func _physics_process(delta):
	add_collision_exception_with(shooter.ball)

func _on_body_entered(body):
	if body != shooter:
		delete = true
		if body.has_method("update_move_speed") and not shooter.opp_slowed and not shooter.opp_slowed_big:
			print("hit")
			delete = true
			body.update_move_speed(body.move_speed / 10)
			body.charge -= 200 
			
			body.charge = max(0, body.charge)
			
			shooter.opp_slowed_big = true
	if "temp_speed" in body:
		body.temp_speed = -100


func _on_timer_timeout():
	delete = true

func _ready():
	if skin != 0:
		%AnimatedSprite2D.scale = Vector2(2,2)
		%AnimatedSprite2D.animation = "default_" + str(skin)
		%AnimatedSprite2D.play()
