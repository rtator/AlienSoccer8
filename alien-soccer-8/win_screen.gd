extends Control

@onready var text = %Label

func _ready():
	Engine.time_scale = 1
	if GlobalSave.winner == 1:
		text.text = "PLAYER 1"
		text.label_settings.font_color = Color.PALE_VIOLET_RED
	if GlobalSave.winner == 2:
		text.text = "PLAYER 2"
		text.label_settings.font_color = Color.CORNFLOWER_BLUE
	if GlobalSave.playing_pve:
		$VBoxContainer.position.y = 130
		text.text = "YOU"
		%Label2.text = "LOSE"
		text.label_settings.font_color = Color.RED
		%wave_counter.visible = true
		%wave_counter.text = "You Reached:\n Wave " + str(PveSave.wave)
		GlobalSave.playing_pve = false

func _physics_process(delta):
	%ColorRect.color.a -= 0.01
	if %ColorRect.color.a <= 0:
		%ColorRect.visible = false

func _on_button_pressed():
	if PveSave.is_pve:
		get_tree().change_scene_to_file("res://game_modes.tscn")
	else:
		get_tree().change_scene_to_file("res://stage_select_screen.tscn")
