extends alien

var rope_load = preload("res://explorer_rope.tscn")
var rope

var hook_load = preload("res://explorer_hook_shot.tscn")
var hook
var hook_out = false
var hook_out_ult = false
#the mult of your speed when the hook is out
var hook_move_mult = 0.5
var hook_pull_speed = 70 * 0.7

var test_node = Node2D.new()

var max_cooldown = 150

var bodies_in =  0

func _ability():
	if cooldown <= 0 and duration <= 0 and not hook_out_ult and not hook_out:
		update_move_speed(move_speed * hook_move_mult)
		
		spawn_hook()
		cooldown = max_cooldown

func spawn_hook(ult = false):
	hook = hook_load.instantiate()
	hook.position = position
	hook.user = self
	hook.linear_velocity = last_input.normalized() * hook.base_vel
	hook.ult = ult
	hook.hit.connect(hook_hit)
	hook.delete.connect(hook_delete)
	add_sibling(hook)
	if ult:
		hook_out_ult = true
	else:
		hook_out = true
	
	rope.hook = hook
	add_sibling(rope)
	rope.active = true

func _ultimate():
	if charge >= charge_max and not hook_out_ult and not hook_out:
		update_move_speed(move_speed * hook_move_mult)
		
		spawn_hook(true)
		charge = 0

func _ability_cooldown(delta):
	if charge < charge_max and not hook_out_ult:
		charge += delta * charge_mult
	
	if cooldown > 0 and not hook_out:
		cooldown -= 1 * delta

func on_ready():
	rope = rope_load.instantiate()
	add_sibling(rope)
	
	rope.parent = self
	
	base_scale = 0.7
	
	if skin != 0:
		%AnimatedSprite2D.animation = "default_" + str(skin)
	
	charge_max = 400
	
	update_move_speed(move_speed * 0.7, speed_damp)
	hook_pull_speed = move_speed * 2

func hook_hit():
	pass

func hook_delete():
	update_move_speed(move_speed / hook_move_mult)
	hook_out = false
	hook_out_ult = false
	rope.active = false

func _on_timer_timeout():
	if hook_out:
		hook.hit_parent = true

func _on_body_entered(body):
	bodies_in += 1
	if hook_out:
		%Timer.start()


func _on_body_exited(body):
	bodies_in -= 1
	if bodies_in <= 0:
		bodies_in = 0
		%Timer.stop()
