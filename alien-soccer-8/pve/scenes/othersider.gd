extends RigidBody2D

var hitbox

var is_othersider = true


@export_category("physics")
@export var move_speed = 10
@export var speed_damp = 10
@export var squish = 80
@export var stretch = 60

@onready var health_bar = %health_bar
@onready var sprite = %sprite

var speed_changes = []

var health
var damage = 2

var target := Vector2(576,324)

var guys_in_area = 0

var othersider_type = "blue"

var orange_explosion_load = preload("res://pve/scenes/orange_explosion.tscn")

var hit_statue = false

var othersider_types = {
	"red": {
		"on_ready": func():
			damage += 1
			move_speed -= 2.5,
		"sprite": preload("res://pve/assets/othersider_r.png"),
	},
	"orange": {
		"on_ready": func():
			scale *= 1.3,
		"on_die": func():
			if hit_statue:
				var orange_explosion = orange_explosion_load.instantiate()
				orange_explosion.position = position
				add_sibling(orange_explosion),
		"sprite": preload("res://pve/assets/othersider_o.png"),
	},
	"yellow": {
		"on_ready": func():
			move_speed += 5
			health_bar.max_value -= 1,
		"sprite": preload("res://pve/assets/othersider_y.png"),
		},
	"green": {
		"on_ready": func():
			move_speed -= 2.5
			health_bar.max_value += 0.5
			health_bar.value += 0.5,
		"sprite": preload("res://pve/assets/othersider_g.png"),
		},
	"blue": {
		"sprite": preload("res://pve/assets/othersider_b.png"),
		},
	#"purple": 
}

signal die(othersider)

# speed changes
#region New Code Region
func update_move_speed(new_speed = move_speed, new_damp = speed_damp):
	print(new_damp)
	move_speed = new_speed
	speed_damp = new_damp
	linear_damp = speed_damp

func add_speed_mult(speed_mult = 1,  time = 100, damp_mult = 1, indentifier = ""):
	print("mult: ", speed_mult)
	update_move_speed(move_speed * speed_mult, speed_damp * damp_mult)
	speed_changes.append([time, speed_mult, damp_mult, indentifier])

func change_speed_mults(delta):
	for change in speed_changes:
		change[0] -= delta
		if change[0] <= 0:
			var speed_mult = change[1]
			var damp_mult = change[2]
			update_move_speed(move_speed / speed_mult, speed_damp / damp_mult)
	
	speed_changes = speed_changes.filter(remove_change)

func remove_change(change):
	return change[0] > 0
#endregion

# misc
#region New Code Region
func ai(delta):
	if PveSave.statue != null:
		target = PveSave.statue.position
	
	var move_vec = (target - position).normalized()
	
	linear_velocity += move_vec * move_speed * delta * 60

func take_damage(delta):
	health_bar.value -= delta * guys_in_area
	
	if health_bar.value <= 0:
		die.emit(self)
		if "on_die" in othersider_types[othersider_type]:
			othersider_types[othersider_type].on_die.call()
		print("die")
		queue_free()
#endregion

# built in funcs (ready, physics proccess, etc)
#region New Code Region
func _physics_process(delta):
	take_damage(delta)
	change_speed_mults(delta)
	ai(delta)

func _ready():
	othersider_type = othersider_types.keys()[randi_range(0, len(othersider_types.keys()) - 1)]
	var dict = othersider_types[othersider_type]
	if "on_ready" in dict:
		dict.on_ready.call()
	if "sprite" in dict:
		sprite.texture = dict.sprite
	
	print("othersider: " + str(othersider_type))
	
	hitbox = %CollisionShape2D
	update_move_speed()

func _on_body_entered(body):
	if PveSave.statue != null:
		if PveSave.statue == body:
			hit_statue = true
			PveSave.statue.get_hurt(damage)
			die.emit(self)
			if "on_die" in othersider_types[othersider_type]:
				othersider_types[othersider_type].on_die.call()
			
			print("die")
			queue_free()

func _on_hit_area_body_entered(body):
	if body.has_method("update_move_speed") and not "is_othersider" in body:
		guys_in_area += 1

func _on_hit_area_body_exited(body):
	if body.has_method("update_move_speed") and not "is_othersider" in body:
		guys_in_area -= 1
#endregion
