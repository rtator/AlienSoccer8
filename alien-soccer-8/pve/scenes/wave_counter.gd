extends Label

func _physics_process(delta):
	update_text()

#sets the text to show the correct wave
func update_text():
	var new_text = "Wave " + str(PveSave.wave)
	
	text = new_text
