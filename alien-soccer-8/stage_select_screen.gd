extends Control


func set_stage(stage : String):
	GlobalSave.stage = stage
	get_tree().change_scene_to_file("res://newAlienSelect.tscn")

func _on_jungle_pressed():
	set_stage("jungle")

func _on_classic_pressed():
	set_stage("classic")

func _on_real_soccer_pressed():
	set_stage("realSoccer")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://startScreen.tscn")
