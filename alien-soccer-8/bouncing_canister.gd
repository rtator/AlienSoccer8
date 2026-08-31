extends RigidBody2D

var user

var bounce_vec := Vector2(0,0)

var icon_load = preload("res://icon_gd.tscn")
var icon

var area_load = preload("res://smog_cloud_area.tscn")
var areas = []
var dead_areas = []

var stretch_length = 40

var return_factor = 300

var move_speed = 300

var trail_start_timer = 0
var trail_start_timer_max = 2

var bounces = 0
var bounces_max = 5

var dead = false

func _ready():
	add_collision_exception_with(user.opponent)
	
	bounce_vec = position
	areas.append([area_load.instantiate(), bounce_vec, Vector2(0,0), bounce_vec, 0])
	areas[0][0].position = position
	areas[0][0].user = user
	add_sibling(areas[0][0])

func _physics_process(delta):
	
	if user.player == 1 and position.x > 576:
		set_collision_layer_value(8, true)
		set_collision_mask_value(8, true)
		print("set")
	elif user.player == 2 and position.x < 576:
		set_collision_layer_value(4, true)
		set_collision_mask_value(4, true)
		print("set")
	
	
	linear_velocity = linear_velocity.normalized() * move_speed
	
	var index = 0
	for area_list in areas:
		var bounce_vec_temp = area_list[1]
		var area = area_list[0]
		print(area_list[2].length())
		if area_list[2].length() <= 0:
			area.position = bounce_vec_temp.lerp(position, 0.5)
			area.rotation = (area_list[1] - position).normalized().angle() 
			area.scale.x = area_list[1].distance_to(position) / stretch_length
			print("not dead, ", area_list)
			if (area_list[0].position - position).length() <= 10 and dead:
				area_list[0].die()
				areas[index] = 0
				dead_areas.append(areas[index])
				print("dead, ", areas[index])
		else:
			var pos = area_list[2]
			area.position = bounce_vec_temp.lerp(pos, 0.5)
			area.rotation = (area_list[1] - pos).normalized().angle() 
			area.scale.x = area_list[1].distance_to(pos) / stretch_length
			print("not dead")
			if (area_list[0].position - pos).length() <= 10 and trail_start_timer >= trail_start_timer_max:
				area_list[0].die()
				areas[index] = 0
				dead_areas.append(areas[index])
				print("dead")
		
		index += 1
	
	if len(dead_areas) > 0:
		print("dead2")
		print(dead_areas[0], " ", areas[0])
		areas.erase(dead_areas[0])
		dead_areas.remove_at(0)
	if len(areas) > 0:
		if trail_start_timer <= trail_start_timer_max:
			trail_start_timer += delta
			#print("trail ", )
		elif areas.front()[2].length() <= 0:
			#areas.front()[1] = areas.front()[1].lerp(position, 0.01)
			areas.front()[1] += (position - areas.front()[1]).normalized() * return_factor * delta
		else:
			#areas.front()[1] = areas.front()[1].lerp(areas.front()[2], 0.01)
			areas.front()[1] += (areas.front()[2] - areas.front()[1]).normalized() * return_factor * delta
	

func die():
	move_speed = 0
	%canister_sprite.visible = false
	%CollisionShape2D.disabled = true
	%smoke_cloud.emitting = false
	%smog_cloud.restart()
	
	dead = true

func _on_body_entered(body):
	#if bounces < bounces_max + 1:
		bounces += 1
		if len(areas) > 0:
			areas.back()[2] = position
		
		bounce_vec = position
		areas.append([area_load.instantiate(), bounce_vec, Vector2(0,0), bounce_vec, 0])
		areas.back()[0].position = position
		areas.back()[0].user = user
		add_sibling(areas.back()[0])
		print("back ", areas.back())
		if (not bounces < bounces_max) and $Timer.is_stopped():
	#elif $Timer.is_stopped():
			$Timer.start()

func _on_smog_cloud_finished():
	if bounces >=  bounces_max:
		for i in areas:
			i[0].die()
		
		if len(areas) > 0:
			areas.back()[2] = position
		
		user.ult_bomb_out = false
		
		queue_free()

func _on_timer_timeout():
	die()
