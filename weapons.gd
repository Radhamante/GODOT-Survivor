extends Node2D

var selected = 0

const GUN = preload("res://weapons/weapons/gun/scene/gun.tscn")
const SHOTGUN = preload("res://weapons/weapons/shotgun/scene/shotgun.tscn")
const MACHINEGUN = preload("res://weapons/weapons/machinegun/scene/machinegun.tscn")
const FLAMETHROWER = preload("res://weapons/weapons/flamethrower/scene/flamethrower.tscn")

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
	
