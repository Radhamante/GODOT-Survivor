extends Node2D

var selected = 0

const GUN = preload("res://weapons/ranged_weapons/gun/scene/gun.tscn")
const SHOTGUN = preload("res://weapons/ranged_weapons/shotgun/scene/shotgun.tscn")
const MACHINEGUN = preload("res://weapons/ranged_weapons/machinegun/scene/machinegun.tscn")
const FLAMETHROWER = preload("res://weapons/ranged_weapons/flamethrower/scene/flamethrower.tscn")
const SWORD = preload("res://weapons/melee_weapons/sword/scene/sword.tscn")
const FORCEFIELD = preload("res://weapons/melee_weapons/forcefield/scene/forcefield.tscn")
const SLASH = preload("res://weapons/ranged_weapons/slash/scene/slash.tscn")
const BOUCING_BOLT = preload("res://weapons/ranged_weapons/boucing_bolt/scene/boucing_bolt.tscn")
@export var weapons = [
	FORCEFIELD, BOUCING_BOLT
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
	
