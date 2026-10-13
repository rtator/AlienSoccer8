extends Node

var round = 0

var is_pve = false

var p1
var p2

var ball_number = 2

var statue : StaticBody2D

var trinkets = []

var common_chance = 80
var uncommon_chance = 20

var common_trinkets = {
	"running_shoes": preload("res://pve/scenes/trinkets/running_shoes_trinket.tscn"),
	"medkit": preload("res://pve/scenes/trinkets/medkit.tscn"),
	"rollerskates": preload("res://pve/scenes/trinkets/rollerskates_trinket.tscn"),
	"batteries": preload("res://pve/scenes/trinkets/batteries_trinket.tscn"),
}
var uncommon_trinkets = {
	"barricade": preload("res://pve/scenes/trinkets/barricade_trinket.tscn"),
}
