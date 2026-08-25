extends Area2D

var user
var ball

var hit = false
var firing = false

func _physics_process(delta):
	if ball == null and user != null:
		ball = user.ball
	
	modulate = modulate.lerp(Color(1,1,1,0), 0.1)
	
	scale = scale.lerp(Vector2(1,1), 0.5)
	
	if modulate.a <= 0.1 and firing:
		firing = false
		
		if not hit:
			user.cooldown = 400
		
		hit = false
		
		monitoring = false

func fire():
	firing = true
	
	monitoring = true
	scale = Vector2(0,0)
	visible = true
	modulate = Color(4,4,4,1)

func _on_body_entered(body):
	if body == ball:
		hit = true
		user.hit_ball()
