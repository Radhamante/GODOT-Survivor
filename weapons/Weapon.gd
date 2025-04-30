extends Area2D
class_name Weapon

@export var weapon_name:String
@export var hit_effects: Array[EffectComponent] = []

@export var upgrade_tree: WeaponUpgradeNode
@onready var next_upgrades: Array[WeaponUpgradeNode] = [upgrade_tree]
