extends EffectComponent
class_name DamageOverTimeEffect

@export var damage_source: DamageSource
@export var tick_interval: float = .5
@export var duration: float = 3.0
var id = generate_scene_unique_id()

func apply(caller: Variant, monster: Monster) -> void:
	monster.apply_dot(id, damage_source, tick_interval, duration)
