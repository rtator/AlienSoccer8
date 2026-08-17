extends Area2D

func _on_body_entered(body):
	if "touching_ore" in body:
		body.touching_ore = true


func _on_body_exited(body):
	if "touching_ore" in body:
		body.touching_ore = false
