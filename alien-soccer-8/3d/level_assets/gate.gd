extends StaticBody3D

@export var switch : Node

func _ready():
	if switch != null and switch.has_signal("trigger"):
		switch.trigger.connect(open)

func open():
	print("open")
	%AnimationPlayer.play("open")
