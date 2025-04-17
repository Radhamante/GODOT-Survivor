extends EffectComponent
class_name DamageEffect

@export var damage_source: DamageSource

func apply(caller: Variant, monster: Monster) -> void:
	monster.take_damage(damage_source)
