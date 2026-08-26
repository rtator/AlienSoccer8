extends Node2D

@onready var body = %body

func _ready():
	var rand_numb = randf()
	var vec = Vector2(randi_range(-40,40), (rand_numb/abs(rand_numb)) * 80)
	body.position = vec
	
	body.linear_velocity = Vector2(-500,0)

func _physics_process(delta):
	body.linear_velocity *= 1.0015
	
	body.linear_velocity += (Vector2(0,0) - body.position).normalized() * 50
