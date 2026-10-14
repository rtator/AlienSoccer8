extends Node2D
class_name Trinket

var trinket_name := "base_trinket"

var grab_box : Area2D
var info_box : Area2D

var info_text  := "I'm the default debug text: if you're seeing me, something is probably wrong"
var control_info_box : Control

var sprite

var disabled = false

var time_base_anim =  0
@export_group("Animation")
@export var all_anim_speed_mult = 1.0
@export var hover_strength = 15.0
@export var hover_speed = 3.0
@export var rot_speed = 1.5
@export var rot_offset_mult = 2.0
@export var rot_strength = 0.2

signal grabbed

var info_shown = false
var guys_in_info = 0

func _ready():
	time_base_anim += randf_range(1, 100)
	
	on_ready()
	
	if grab_box != null:
		grab_box.body_entered.connect(base_on_grab)
	if info_box != null:
		print("info_box != null")
		info_box.body_entered.connect(show_info)
		info_box.body_exited.connect(hide_info)
	if control_info_box != null:
		control_info_box.visible = false

func on_ready():
	pass

func _physics_process(delta):
	base_anim(delta)
	anim(delta)
	update_info()

func update_info():
	if control_info_box != null and not disabled and info_shown:
		control_info_box.visible = true
	elif control_info_box != null:
		control_info_box.visible = false

func base_anim(delta):
	time_base_anim += delta * all_anim_speed_mult
	
	if sprite != null:
		sprite.position.y = sin(time_base_anim * hover_speed) * hover_strength
		sprite.rotation = cos(time_base_anim * rot_speed) * rot_strength

func anim(delta):
	pass

func base_on_grab(body):
	if not disabled:
		grabbed.emit()
		on_grab()

func on_grab():
	pass

func show_info(body):
	if body.has_method("update_move_speed"):
		guys_in_info += 1
		info_shown = true

func hide_info(body):
	if body.has_method("update_move_speed"):
	
		guys_in_info -= 1
		if guys_in_info <= 0:
			info_shown = false
