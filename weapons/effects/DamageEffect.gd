extends EffectComponent
class_name DamageEffect

@export var damage_source: DamageSource

func apply(caller: Variant, monster: Monster) -> void:
	monster.take_damage(damage_source)

func get_display_value() -> String:
	var result = "On hit : \n"
	result+= "Damage : %d \n" % damage_source.damage
	result+= "Types : %s\n" % ", ".join(
		damage_source.types.map(func(value):
			for k in Enums.DamageType:
				if Enums.DamageType[k] == value:
					return k
			return str(value) # fallback
			)
	)
	return result
