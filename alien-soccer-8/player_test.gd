extends RigidBody2D
class_name alien

@export_category("physics")
@export var move_speed = 70
@export var speed_damp = 10
@export var squish = 30
@export var stretch = 40

var player = 1

var last_input = Vector2(-1, 0)
var input

var duration = 0
var ult_dur = 0
var cooldown = 0
var charge = 0
var charge_bar
var cooldown_bar
var charge_max = 1000

var base_scale = 1

var sprite
var hitbox
var sprite_scale = Vector2(1,1)
var initialized = false

var ball
var opponent
var character

var is_bot = false

func _physics_process(delta_milliseconds):
	var delta = delta_milliseconds*60
	
	if not is_bot:
		if player == 1:
			input = Input.get_vector("p1_left", "p1_right","p1_up","p1_down")
		else:
			input = Input.get_vector("p2_left", "p2_right","p2_up","p2_down")
	else:
		if initialized:
			input = (ball.position - position)
			input.x = 0
			if input.length() > 25:
				if (player == 1):
					if position.x >= 50 and ball.linear_velocity.length() > 0:
						input.x = -input.length()/2
					elif ball.linear_velocity.length() <= 0:
						input.x = input.length()/2
				else:
					if position.x <= 1102 and ball.linear_velocity.length() > 0:
						input.x = input.length()/2
					elif ball.linear_velocity.length() <= 0:
						input.x = -input.length()/2
				input = input.normalized()
			else:
				input = Vector2(0,0)
				if (player == 1):
					if position.x >= 50 and ball.linear_velocity.length() > 0:
						input.x = -1
					elif ball.linear_velocity.length() <= 0:
						input.x = 1
				else:
					if position.x <= 1102 and ball.linear_velocity.length() > 0:
						input.x = 1
					elif ball.linear_velocity.length() <= 0:
						input.x = -1
		else:
			input = Vector2(0,0)
		_ultimate()

	
	input *= move_speed * delta
	linear_velocity += input
	
	if input.length() > 0:
		last_input = input.normalized()
	
	_ability_cooldown(delta)
	if (initialized):
		sprite.skew = linear_velocity.x/(move_speed*stretch)
		#print(sprite.scale)
		sprite.scale.x = sprite_scale.x + (linear_velocity.y/(move_speed*squish)) * sprite_scale.y
		sprite.scale.y = sprite_scale.y - (linear_velocity.y/(move_speed*squish)) * sprite_scale.y
		charge_bar.value = charge
		charge_bar.max_value = charge_max
		cooldown_bar.value = cooldown
		cooldown_bar.max_value = max(cooldown_bar.max_value, cooldown)
	scale = Vector2(base_scale, base_scale)

func update_move_speed(new_speed = move_speed, new_damp = speed_damp):
	print(new_damp)
	move_speed = new_speed
	speed_damp = new_damp
	linear_damp = speed_damp

func update_scale(new_scale):
	print(new_scale)
	base_scale = new_scale
	hitbox.scale = Vector2(base_scale, base_scale)
	#sprite_scale = Vector2(base_scale, base_scale)

func _ability():
	print("ability")

func _ultimate():
	print("ult")

func _ability_cooldown(delta):
	pass

func _unhandled_input(event):
	if not is_bot:
		if event.is_action_pressed("p1_ability") and player == 1:
			_ability()
		elif event.is_action_pressed("p2_ability") and player == 2:
			_ability()
		
		if event.is_action_pressed("p1_ult") and player == 1:
			_ultimate()
		elif event.is_action_pressed("p2_ult") and player == 2:
			_ultimate()

func set_player(playerNumb):
	player = playerNumb
	if player == 1:
		set_collision_mask_value(8, false)
		set_collision_mask_value(4, true)
	if player == 2:
		set_collision_mask_value(8, true)
		set_collision_mask_value(4, false)

func on_ready():
	pass

func _ready():
	on_ready()
	
	hitbox = %CollisionShape2D
	sprite = %AnimatedSprite2D
	sprite_scale = sprite.scale
	initialized = true
	update_scale(base_scale)
