extends Resource
class_name DamageSource

@export var damage: float = 1.0
@export var armor_penetration: float = 0.0
@export var crit_chance: float = 0.0
@export var crit_damage: float = 1.5
@export var types: Array[Enums.DamageType] = []
@export_range(0,1) var damage_reduction_on_piercing: float = 0
