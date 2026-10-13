extends Node2D

var shop_keeper = "basic"

var alienTextures = {
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
	"cloaker": preload("res://as8_sprites_png/cloaker.png"),
	"pirate": preload("res://as8_sprites_png/pirate.png"),
	"mothership": preload("res://as8_sprites_png/mothership.png"),
	"warden": preload("res://as8_sprites_png/warden.png"),
	"nuclear": preload("res://as8_sprites_png/nuclear.png"),
	"breezer": preload("res://as8_sprites_png/breezer.png"),
	"decayed": preload("res://as8_sprites_png/decayed.png"),
}

var flavour_text_options = [
	"Hi! I'm [alien].",
	"Heres a little something to help you on your way.",
	"Feel free to take your time!",
	"Welcome to '[alien] & Co.'! Feel free to peruse our wares.",
	"Thank you [p1] and [p2] for protecting us from those terrible othersiders! Here, take a free power-up.",
	"What a magnificent statue you have here! Wouldn't want it to break, now would you?",
	"Oh, [p1]! Nice seeing you, it's been a while.",
	"Oh, [p2]! Nice seeing you, it's been a while.",
	"Whoah, real pro soccer players! [p1], can I have your autograph pleeeease?",
	"I lost my home to the othersiders, but I have enought to help you guys fight. Take one of these!",
]

var texture_array = []

func _ready():
	alienTextures.erase(GlobalSave.p1Char)
	alienTextures.erase(GlobalSave.p2Char)
	
	texture_array = alienTextures.values()
	new_char()

func new_char():
	var rand_i = randi_range(0, len(texture_array) - 1)
	
	%TextureRect.texture = texture_array[rand_i]
	shop_keeper = alienTextures.keys()[rand_i]
	
	gen_flavour_text()

func gen_flavour_text():
	var text : String = flavour_text_options[randi_range(0, len(flavour_text_options) - 1)]
	
	var shop_keeper_text = shop_keeper.capitalize()
	var p1_text = GlobalSave.p1Char.capitalize()
	var p2_text = GlobalSave.p2Char.capitalize()
	
	text = text.replace("[alien]", shop_keeper_text)
	text = text.replace("[p1]", p1_text)
	text = text.replace("[p2]", p2_text)
	
	%Flavour_text.text = text
