extends Node2D

func _ready():
	if OS.has_feature("server"):
		%Camera2D.make_current()
