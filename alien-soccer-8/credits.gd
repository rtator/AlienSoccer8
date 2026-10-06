extends Control

@onready var back_mod = $backButton.modulate

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://game_info.tscn")

func _physics_process(delta):
	print("value: ", $ScrollContainer.get_v_scroll_bar().value, " max: ", $ScrollContainer.get_v_scroll_bar().max_value)
	if $ScrollContainer.get_v_scroll_bar().value + $ScrollContainer.get_v_scroll_bar().page == $ScrollContainer.get_v_scroll_bar().max_value:
		$backButton.modulate = Color(1,1,1,1)
		print("max")
	else:
		$backButton.modulate = back_mod
