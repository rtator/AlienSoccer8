extends CanvasLayer

@onready var panel_1 = %Panel1
@onready var panel_2 = %Panel2


func p1():
	panel_2.visible = true

func p1_done():
	panel_2.visible = false

func p2():
	panel_1.visible = true

func p2_done():
	panel_1.visible = false
