extends EffectComponent
class_name DamageOverTimeEffect

@export var damage_source: DamageSource
@export var tick_interval: float = .5
@export var duration: float = 3.0
var id = generate_scene_unique_id()

func apply(caller: Variant, monster: Monster) -> void:
	monster.apply_dot(id, damage_source, tick_interval, duration)

func get_display_value() -> String:
	var result = "Damage over time : \n"
	result+= "Damage : %d \n" % damage_source.damage
	result+= "Types : %s\n" % ", ".join(
		damage_source.types.map(func(value):
			for k in Enums.DamageType:
				if Enums.DamageType[k] == value:
					return k
			return str(value) # fallback
			)
	)
	result+= "Delay : %d\n" % tick_interval
	return result
