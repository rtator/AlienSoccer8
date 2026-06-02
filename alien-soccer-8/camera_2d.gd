extends Camera2D

var shake_amount = 0
var shake_fade = 0.8

func shake(strength):
	shake_amount = strength

func _process(delta):
	offset = get_shake_vec(shake_amount)
	
	shake_amount *= shake_fade

func get_shake_vec(amount):
	return Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))
	
