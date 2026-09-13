extends CanvasLayer

@onready var rect = %ColorRect

var ulting = false

var base_pos = 1152
var target_pos = 0
var speed = 7500

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta):
	if ulting:
		if rect.position.x > target_pos:
			rect.position.x -= speed * delta
		else:
			rect.position.x = target_pos
	else:
		if rect.position.x <= target_pos and rect.position.x > -base_pos:
			rect.position.x -= speed * delta
		else:
			rect.position.x = base_pos + 1

func ult():
	ulting = true
	print("ulting: ", ulting)

func end():
	ulting = false
	#rect.position.x = base_pos
