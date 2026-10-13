extends StaticBody2D

var camera

@onready var hearts = [%heart1, %heart2, %heart3, %heart4, %heart5]
var dead_heart_mod = Color(0.5,0.5,0.5)

var max_health = 5
var health = max_health:
	set(new):
		health = new
		update_health_bar()

var max_flash_amount = 4
var flashed_amount = 0
var is_invincible = false 
var flashing = false
var grey_mod = Color(0.5,0.5,0.5)

signal die

func _ready():
	PveSave.statue = self

func update_health_bar():
	if health <= 0:
		emit_signal("die")
	
	for heart in hearts:
		heart.modulate = grey_mod
	for i in range(health):
		hearts[i].modulate = Color(1,1,1)

func get_hurt(damage : int = 1):
	if camera != null:
		camera.shake(GlobalSave.screenShake)
	
	health = health - damage
	
	is_invincible = true
	modulate = grey_mod
	flashing = true
	flashed_amount = 0
	%flash_timer.start()


func _on_flash_timer_timeout(): 
	print("Timer")
	if is_invincible:
		if flashed_amount < max_flash_amount:
			flashed_amount += 1
			if flashing:
				flashing = false
				modulate = Color.WHITE
			else:
				flashing = true
				modulate = grey_mod
		else:
			is_invincible = false
			flashing = false
			modulate = Color.WHITE
	else:
		%flash_timer.stop()

func _on_area_2d_body_entered(body):
	if "ball_speed" in body and not is_invincible:
		get_hurt()
