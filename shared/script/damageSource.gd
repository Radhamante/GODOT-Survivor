extends Resource
class_name DamageSource

@export var damage: float = 1.0
@export var armor_penetration: float = 0.0
@export var crit_chance: float = 0.0
@export var crit_damage: float = 1.5
@export var types: Array[Enums.DamageType] = []
@export var particules: PackedScene
@export_range(0,1) var damage_reduction_on_piercing: float = 0
@export var knockback_force: float = 0.0
var source_position: Vector2 = Vector2.ZERO
