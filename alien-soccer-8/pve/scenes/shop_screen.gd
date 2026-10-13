extends Node2D

@onready var stand = %shop_stand

@onready var trinket_slots = [%left, %middle, %right]

var current_trinkets = []

signal over

func _ready():
	new_trinkets()
	stand.new_char()

func open_shop():
	new_trinkets()
	stand.new_char()
	%AnimationPlayer.play("fly_in")

func new_trinkets(disabled = true):
	for slot in trinket_slots:
		if len(slot.get_children()) > 0:
			current_trinkets.clear()
			for child in slot.get_children():
				child.queue_free()
	for slot in trinket_slots:
		var rarity_percent_max = PveSave.uncommon_chance + PveSave.common_chance
		var rarity_rand = randf_range(0, rarity_percent_max)
		var rarity
		if rarity_rand < PveSave.uncommon_chance:
			rarity = "uncommon"
		elif rarity_rand < PveSave.uncommon_chance + PveSave.common_chance:
			rarity = "common"
		
		var rand_numb
		var name
		var trinket
		if rarity == "common":
			rand_numb = randi_range(0, len(PveSave.common_trinkets) - 1)
			trinket = PveSave.common_trinkets.values()[rand_numb]
			name = PveSave.common_trinkets.keys()[rand_numb]
		elif rarity == "uncommon":
			rand_numb = randi_range(0, len(PveSave.uncommon_trinkets) - 1)
			trinket = PveSave.uncommon_trinkets.values()[rand_numb]
			name = PveSave.uncommon_trinkets.keys()[rand_numb]
		
		
		trinket = trinket.instantiate()
		trinket.disabled = disabled
		trinket.grabbed.connect(close_shop)
		slot.add_child(trinket)
		
		var current_trinket  = {"name": name, "trinket": trinket}
		current_trinkets.append(current_trinket)

func close_shop():
	disable_trinkets()
	%AnimationPlayer.play("fly_out")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fly_in":
		print("enabled")
		enable_trinkets()
	elif anim_name == "fly_out":
		over.emit()

func disable_trinkets():
	for trinket_obj in current_trinkets:
		var trinket = trinket_obj.trinket
		trinket.disabled = true

func enable_trinkets():
	print("current_trinkets: ", current_trinkets)
	for trinket_obj in current_trinkets:
		var trinket = trinket_obj.trinket
		trinket.disabled = false
