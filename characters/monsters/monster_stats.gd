# res://resources/monster/monster_stats.gd
extends Resource
class_name MonsterStats

@export var health: float = 1.0
@export var speed: float = 300.0
@export var damage: float = 1.0
@export var armor: float = 0.0
# Each resistance is a multiplier. 1 = no resistance, 0 = full resistance, >1 weakness
@export var resistance: Dictionary[Enums.DamageType, float] = {}
@export var knockback_resitance: float = 1.0 # 1.0 = no resistance, 0.5 = 50% push, 0 = immune
