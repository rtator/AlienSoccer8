extends Button

@export var input: String

func _init():
	toggle_mode = true

func _ready():
	set_process_unhandled_key_input(false)
	update_text()

func _toggled(toggled_on):
	set_process_unhandled_key_input(toggled_on)
	if toggled_on:
		text = "waiting"

func _unhandled_key_input(event):
	if event.is_pressed():
		InputMap.action_erase_events(input)
		InputMap.action_add_event(input, event)
		button_pressed = false
		release_focus()
		update_text() 
		set_process_unhandled_key_input(false)

func update_text():
	text = InputMap.action_get_events(input)[0].as_text().left(1)
