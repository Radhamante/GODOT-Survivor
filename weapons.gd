extends Node2D

var selected = 0

const GUN = preload("res://pistols/gun/scene/gun.tscn")
const FLAMETHROWER = preload("res://pistols/flamethrower/scene/flamethrower.tscn")
const SHOTGUN = preload("res://pistols/shotgun/scene/shotgun.tscn")
const MACHINEGUN = preload("res://pistols/machinegun/scene/machinegun.tscn")

@export var weapons = [
	GUN, SHOTGUN, FLAMETHROWER, MACHINEGUN
]
var weapon_index = 0

func _ready():
	select_gun(weapon_index)

func _input(event):
	if event.is_action_pressed("ui_select"):
		weapon_index = (weapon_index + 1) % weapons.size()
		select_gun(weapon_index)
		
		
func select_gun(index:int): 
	remove_child(get_child(0))
	add_child(weapons[index].instantiate())
	
