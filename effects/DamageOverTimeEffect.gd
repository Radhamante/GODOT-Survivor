extends EffectComponent
class_name DamageOverTimeEffect

@export var damage_source: DamageSource
@export var tick_interval: float = .5
@export var duration: float = 3.0

func apply(monster: Monster) -> void:
	monster.apply_dot(damage_source, tick_interval, duration)
