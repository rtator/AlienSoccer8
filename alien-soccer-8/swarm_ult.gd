extends Node2D

@onready var body = %body
@onready var sprite = %sprite

var spin_speed = 3.0

var base_pos = Vector2(0,90)

var buzz_range = 3.0
var buzz_dir = -1.0

signal hit(body)

func _ready():
	if rotation == 0:
		rotation_degrees = randi_range(0,360)
	
	spin_speed += randi_range(0, 3)/3
	
	body.position *= randf_range(1, 1.7)
	
	var rn = randf_range(0.01, 0.4) - 0.25
	spin_speed *= abs(rn)/rn
	
	pass

func _physics_process(delta):
	if body != null:
		body.global_scale = Vector2(1,1)
		
		
		
		rotation += 1 * delta * spin_speed
		body.global_rotation = 0
		
		body.position = base_pos
		#body.position.y += buzz_range * buzz_dir
		#buzz_dir *= -1
		#body.position += Vector2(randf_range(-buzz_range,buzz_range), randf_range(-buzz_range,buzz_range))
		#body.scale.y *= -1


func _on_body_body_entered(body):
	emit_signal("hit", body)
