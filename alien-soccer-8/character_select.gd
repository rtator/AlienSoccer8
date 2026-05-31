extends Control



const alienTextures = {
	"basic": preload("res://as8_sprites_png/basic.png"),
	"speedy": preload("res://as8_sprites_png/speedy.png"),
	"scaler": preload("res://as8_sprites_png/scaler.png"),
	"jumper": preload("res://as8_sprites_png/jumper.png"),
}

var p1Rect
var p2Rect

func _ready():
	p1Rect = %p1Rect
	p2Rect = %p2Rect
	
	p1Rect.texture = alienTextures[GlobalSave.p1Char]
	p2Rect.texture = alienTextures[GlobalSave.p2Char]

func update_texture():
	p1Rect.texture = alienTextures[GlobalSave.p1Char]
	p2Rect.texture = alienTextures[GlobalSave.p2Char]

func _on_basic_1_pressed():
	GlobalSave.p1Char = "basic"
	update_texture()
func _on_speedy_1_pressed():
	GlobalSave.p1Char = "speedy"
	update_texture()
func _on_basic_2_pressed():
	GlobalSave.p2Char = "basic"
	update_texture()
func _on_speedy_2_pressed():
	GlobalSave.p2Char = "speedy"
	update_texture()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://level_test.tscn")
	
func _on_p_1_bot_pressed():
	if GlobalSave.p1IsBot:
		GlobalSave.p1IsBot = false
		%p1Bot.text = "Player 1"
	else:
		GlobalSave.p1IsBot = true
		%p1Bot.text = "Bot"
 
func _on_p_2_bot_pressed():
	if GlobalSave.p2IsBot:
		GlobalSave.p2IsBot = false
		%p2Bot.text = "Player 1"
	else:
		GlobalSave.p2IsBot = true
		%p2Bot.text = "Bot"
