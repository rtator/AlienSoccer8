extends RigidBody3D

@onready var raycast = %RayCast3D
@onready var camera = %player_camera
@onready var model = %basic_3D_model

@export_category("Float Vars")
@export var push_dist = 1
@export var push_buffer_dist = 1.5
@export var push_strength = 30
@export var push_slow_mult = 0.9

@export_category("Physics")
@export var move_speed = 100
@export var damp_mult = 0.9

@export_category("Visuals")
@export var turn_speed = 10.0

var target_rot = 0


func _physics_process(delta):
	float_push(delta)
	control(delta)
	rot_to_target(delta)

func control(delta):
	var input = Input.get_vector("p1_right", "p1_left", "p1_down", "p1_up")
	input = input.rotated(-camera.rotation.y)
	var input_3d = Vector3(input.x, 0, input.y)
	
	linear_velocity += input_3d * move_speed * delta
	
	linear_velocity.x *= damp_mult
	linear_velocity.z *= damp_mult
	
	if input.length() > 0:
		rot_to_vec(input)

func rot_to_vec(vec):
	var rot = Vector2(vec.x, vec.y).angle()
	target_rot = -rot + deg_to_rad(90)

func rot_to_target(delta):
	model.rotation.y = lerp_angle(model.rotation.y, target_rot, turn_speed * delta)

func float_push(delta):
	var collision_point = raycast.get_collision_point()
	if raycast.get_collider() != null:
		var dist = position.y - collision_point.y
		if dist <= push_dist:
			gravity_scale = 0
			var strength = (push_dist - dist)
			linear_velocity.y += strength * push_strength * delta
			#linear_velocity.y *= push_slow_mult
		elif dist <= push_buffer_dist:
			gravity_scale = 0
		else:
			gravity_scale = 1
	else:
		gravity_scale = 1
