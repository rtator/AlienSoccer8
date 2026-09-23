extends RigidBody3D

@onready var raycast = %RayCast3D
@onready var camera = %player_camera
@onready var model = %basic_3D_model
@onready var jump_timer = %jump_timer

@export_category("Float Vars")
@export var base_push_dist = 1.0
@export var base_push_buffer_dist = 1.5
@export var base_push_strength = 30.0
@export var push_slow_mult = 0.9

var push_dist = base_push_dist
var push_buffer_dist = base_push_buffer_dist
var push_strength = base_push_strength

@export_category("Physics")
@export var move_speed = 100
@export var damp_mult = 0.9
@export var base_gravity = 4

@export_category("Visuals")
@export var turn_speed = 10.0

@export_category("Jump")
@export var push_dist_grounded_cancel = 2
@export var push_strength_jump = 90.0
var jumping = false
var grounded = false

var target_rot = 0

#Built-In Functions

func _physics_process(delta):
	float_push(delta)
	control(delta)
	rot_to_target(delta)
	print("")

func _unhandled_input(event):
	if event is InputEventKey and event.is_pressed() and event.is_action_pressed("3d_jump"):
		jump()

#Callable Functions

func control(delta):
	var input = Input.get_vector("p1_right", "p1_left", "p1_down", "p1_up")
	input = input.rotated(-camera.rotation.y)
	var input_3d = Vector3(input.x, 0, input.y)
	
	linear_velocity += input_3d * move_speed * delta
	
	linear_velocity.x *= damp_mult
	linear_velocity.z *= damp_mult
	
	if input.length() > 0:
		rot_to_vec(input)

func jump():
	if grounded and not jumping:
		jumping = true
		push_strength = push_strength_jump
		jump_timer.start()

func stop_jump():
	jumping = false
	push_dist = base_push_dist
	push_buffer_dist = base_push_buffer_dist
	push_strength = base_push_strength

func rot_to_vec(vec):
	var rot = Vector2(vec.x, vec.y).angle()
	target_rot = -rot + deg_to_rad(90)

func rot_to_target(delta):
	model.rotation.y = lerp_angle(model.rotation.y, target_rot, turn_speed * delta)

func float_push(delta):
	if not jumping:
		var collision_point = raycast.get_collision_point()
		if raycast.get_collider() != null:
			var dist = position.y - collision_point.y
			grounded = true
			if dist <= push_dist:
				gravity_scale = 0
				var strength = (push_dist - dist)
				linear_velocity.y += strength * push_strength * delta
				#linear_velocity.y *= push_slow_mult
			elif dist <= push_buffer_dist:
				grounded = true
				gravity_scale = 0
			elif dist <= push_dist_grounded_cancel:
				grounded = false
			else:
				grounded = false
				gravity_scale = base_gravity
				#stop_jump()
		else:
			grounded = false
			#stop_jump()
			gravity_scale = base_gravity
	else:
		grounded = false
		gravity_scale = 0
		linear_velocity.y += push_strength * delta
		#linear_velocity.y *= push_slow_mult

func _on_jump_timer_timeout():
	stop_jump()
