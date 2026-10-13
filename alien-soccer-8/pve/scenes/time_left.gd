extends Label

@onready var timer = %time_left_timer
@onready var wave_timer = %new_wave_timer

var time_left = 0
var wave_time_left = 0

var wave_color_buffer = 3
var wave_color = Color(1,0,0)

signal new_wave

func restart():
	timer.start()
	wave_timer.start()
	visible = true

func _physics_process(delta):
	update_time()
	update_wave_display()

func update_time():
	time_left = timer.time_left
	var minutes = floor(time_left/60)
	var seconds_rounded = floor(fmod(time_left, 60))
	var seconds = fmod(time_left, 60)
	var milliseconds = floor(seconds * 100) - floor(seconds_rounded * 100)
	
	if milliseconds < 10:
		milliseconds = "0" + str(milliseconds)
	if seconds_rounded < 10:
		seconds_rounded = "0" + str(seconds_rounded)
	
	var new_text = str(minutes) + ":" + str(seconds_rounded) #+ ":" + str(milliseconds)
	
	new_text = new_text.replace(".0", "")
	
	text = new_text

func update_wave_display():
	wave_time_left = wave_timer.time_left
	if wave_time_left < wave_color_buffer:
		var weight = wave_time_left - floor(wave_time_left)
		var new_color = Color.WHITE.lerp(wave_color, weight)
		modulate = new_color
	else:
		modulate = Color.WHITE

func _on_new_wave_timer_timeout():
	emit_signal("new_wave")

func _on_time_left_timer_timeout():
	wave_timer.stop()
