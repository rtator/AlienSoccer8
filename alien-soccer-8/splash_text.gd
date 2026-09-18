extends Control

@onready var text = %text
@onready var text_settings = text.label_settings

var base_rotation = deg_to_rad(20.0)
var base_txt_size = 15.0
var base_scale = Vector2(1.0,1.0)

var time = 0.0

var possibilities = [
	"Inverted is still meta, right?",
	"Alien Soccer 1 was better",
	"Graded C in 8th grade!",
	"Othersider coming soon! (lie)",
	"Totaly not stolen from minecraft"
]

func _ready():
	var rand_index = randi_range(0, len(possibilities) - 1)
	text.text = possibilities[rand_index]

func _process(delta):
	time += delta * 1.5
	rotation = (sin(time)/5) + base_rotation
	
	scale = base_scale + (base_scale * sin(time * 2.0) / 5)
