extends WeaponModifier
class_name MeleeWeaponModifier

@export var property_name: MeleeWeaponStatsName

enum MeleeWeaponStatsName {
	DAMAGE,
	ARMOR_PENETRATION,
	CRIT_CHANCE,
	CRIT_DAMAGE,
	KNOCKBACK_FORCE,
	ORBIT_SPEED,
}

func _get_stats_name(selected_stat: MeleeWeaponStatsName) -> Array[String]:
	match selected_stat:
		MeleeWeaponStatsName.DAMAGE:
			return ["modified_damage_source","damage"]
		MeleeWeaponStatsName.ARMOR_PENETRATION:
			return ["modified_damage_source","armor_penetration"]
		MeleeWeaponStatsName.CRIT_CHANCE:
			return ["modified_damage_source","crit_chance"]
		MeleeWeaponStatsName.CRIT_DAMAGE:
			return ["modified_damage_source","crit_damage"]
		MeleeWeaponStatsName.KNOCKBACK_FORCE:
			return ["modified_damage_source","knockback_force"]
		MeleeWeaponStatsName.ORBIT_SPEED:
			return ["movement_behavior","orbit_speed"]
		_:
			push_error("Invalid MeleeWeaponStatsName value: " + str(selected_stat))
			return []

func apply(weapon: MeleeWeapon):
	property = _get_stats_name(property_name)
	super._apply(weapon)
