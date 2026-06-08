extends VScrollBar

func _on_value_changed(value):
	if value > 65:
		var change = value - 65
		
		y = change *
