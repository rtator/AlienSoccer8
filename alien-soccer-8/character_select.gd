extends Control



const alienTextures = {
	"basic": preload("res://as8_sprites_png/basic.png"),
	"speedy": preload("res://as8_sprites_png/speedy.png"),
	"scaler": preload("res://as8_sprites_png/scaler.png"),
	"jumper": preload("res://as8_sprites_png/jumper.png"),
	"launcher": preload("res://as8_sprites_png/launcher.png"),
	"freezer": preload("res://as8_sprites_png/freezer.png"),
	"clock": preload("res://as8_sprites_png/clock.png"),
	"trickster": preload("res://as8_sprites_png/trickster.png"),
	"gambler": preload("res://as8_sprites_png/gambler.png"),
	"wrangler": preload("res://as8_sprites_png/wrangler.png"),
	"twins": preload("res://as8_sprites_png/twins_blue.png"),
	"warper": preload("res://as8_sprites_png/warper.png"),
	"target": preload("res://as8_sprites_png/target.png"),
	"spectre": preload("res://as8_sprites_png/spectre.png"),
	"mosquito": preload("res://as8_sprites_png/mosquito.png"),
}
const alienSkins = {
	"basic": preload("res://as8_sprites_png/basic.png"),
	"speedy": preload("res://as8_sprites_png/speedy.png"),
	"scaler": preload("res://as8_sprites_png/scaler.png"),
	"jumper": preload("res://as8_sprites_png/jumper.png"),
	"launcher": preload("res://as8_sprites_png/launcher.png"),
	"freezer": preload("res://as8_sprites_png/freezer.png"),
	"clock": preload("res://as8_sprites_png/clock.png"),
	"trickster": preload("res://as8_sprites_png/trickster.png"),
	"gambler": preload("res://as8_sprites_png/gambler.png"),
	"wrangler": preload("res://as8_sprites_png/wrangler.png"),
	"twins": preload("res://as8_sprites_png/twins_blue.png"),
	"warper": preload("res://as8_sprites_png/warper.png"),
	"target": preload("res://as8_sprites_png/target.png"),
	"spectre": preload("res://as8_sprites_png/spectre.png"),
	"mosquito": preload("res://as8_sprites_png/mosquito.png"),
}

var alien_names = alienTextures.keys()

var p1_selected_button = 0
var p2_selected_button = 0

@onready var alien_buttons = [
	%basic1,
	%speedy1,
	%scaler1,
	%jumper1,
	%launcher1,
	%freezer1,
	%clock1,
	%trickster1,
	%gambler1,
	%wrangler1,
	%twins1,
	%warper1,
	%target1,
	%spectre1,
	%mosquito1,
]

var started = false

var p1Selected = false
var p2Selected = false

@onready var p1Started = %p1Started
@onready var p2Started = %p2Started

var p1Rect
var p2Rect

var p1Style = preload("res://p1Button.tres")
var p2Style = preload("res://p2Button.tres")
var bothStyle = preload("res://bothPButton.tres")
var baseStyle = preload("res://buttonText.tres")

var banner_loaded = preload("res://startBanner.tscn")
var banner
var banner_out = false

func _ready():
	started = true
	
	if p1_selected_button == p2_selected_button:
		alien_buttons[p1_selected_button].add_theme_stylebox_override("normal", bothStyle)
	else:
		alien_buttons[p1_selected_button].add_theme_stylebox_override("normal", p1Style)
		alien_buttons[p2_selected_button].add_theme_stylebox_override("normal", p2Style)
	
	p1Rect = %p1Rect
	p2Rect = %p2Rect
	
	p1Rect.texture = alienTextures[GlobalSave.p1Char]
	p2Rect.texture = alienTextures[GlobalSave.p2Char]

func _process(delta):
	if p1Selected and p2Selected:
		if Input.is_action_just_pressed("start"):
			get_tree().change_scene_to_file("res://level.tscn")
		if not banner_out:
			banner = banner_loaded.instantiate()
			add_child(banner)
			banner_out = true
	elif banner_out:
		banner.queue_free()
		banner_out = false

func update_texture():
	p1Rect.texture = alienTextures[GlobalSave.p1Char]
	p2Rect.texture = alienTextures[GlobalSave.p2Char]

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and started:
		alien_buttons[p1_selected_button].add_theme_stylebox_override("normal", baseStyle)
		alien_buttons[p2_selected_button].add_theme_stylebox_override("normal", baseStyle)
		
		if not p1Selected:
			if event.is_action("p1_right"):
				p1_selected_button += 1
			elif event.is_action("p1_left"):
				p1_selected_button -= 1
			elif event.is_action("p1_up"):
				if ceil((p1_selected_button + 1) / 6) == 2:
					p1_selected_button -= 5
				else:
					p1_selected_button -= 6
				p1_selected_button = clamp(p1_selected_button, 0, len(alien_buttons) - 1)
			elif event.is_action("p1_down"):
				if ceil(p1_selected_button / 6) == 1 and p1_selected_button != 6:
					p1_selected_button += 5
				else:
					p1_selected_button += 6
				p1_selected_button = clamp(p1_selected_button, 0, len(alien_buttons) - 1)
			elif event.is_action("p1_ability"):
				p1Selected = true
				p1Started.visible = true
		elif event.is_action("p1_ability"):
			p1Selected = false
			p1Started.visible = false
		
		if not p2Selected:
			if event.is_action("p2_right"):
				p2_selected_button += 1
			elif event.is_action("p2_left"):
				p2_selected_button -= 1
			elif event.is_action("p2_up"):
				if ceil((p2_selected_button + 1) / 6) == 2:
					p2_selected_button -= 5
				else:
					p2_selected_button -= 6
				p2_selected_button = clamp(p2_selected_button, 0, len(alien_buttons) - 1)
			elif event.is_action("p2_down"):
				if ceil(p2_selected_button / 6) == 1 and p2_selected_button != 6:
					p2_selected_button += 5
				else:
					p2_selected_button += 6
				p2_selected_button = clamp(p2_selected_button, 0, len(alien_buttons) - 1)
			elif event.is_action("p2_ability"):
				p2Selected = true
				p2Started.visible = true
		elif event.is_action("p2_ability"):
			p2Selected = false
			p2Started.visible = false
		
		if p1_selected_button > len(alien_buttons) - 1:
			p1_selected_button = 0
		elif p2_selected_button > len(alien_buttons) - 1:
			p2_selected_button = 0
		
		if p1_selected_button < 0:
			p1_selected_button = len(alien_buttons) - 1
		elif p2_selected_button < 0:
			p2_selected_button = len(alien_buttons) - 1
		
		if p1_selected_button == p2_selected_button:
			alien_buttons[p1_selected_button].add_theme_stylebox_override("normal", bothStyle)
		else:
			alien_buttons[p1_selected_button].add_theme_stylebox_override("normal", p1Style)
			alien_buttons[p2_selected_button].add_theme_stylebox_override("normal", p2Style)
		GlobalSave.p1Char = alien_names[p1_selected_button]
		GlobalSave.p2Char = alien_names[p2_selected_button]
		update_texture()

func _on_p_1_bot_pressed():
	if GlobalSave.p1IsBot:
		GlobalSave.p1IsBot = false
		%p1Bot.text = "Player"
	else:
		GlobalSave.p1IsBot = true
		%p1Bot.text = "Bot"
 
func _on_p_2_bot_pressed():
	if GlobalSave.p2IsBot:
		GlobalSave.p2IsBot = false
		%p2Bot.text = "Player"
	else:
		GlobalSave.p2IsBot = true
		%p2Bot.text = "Bot"
