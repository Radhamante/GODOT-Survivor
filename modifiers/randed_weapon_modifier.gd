extends WeaponModifier
class_name RangedWeaponModifier

@export var property_name: RangedWeaponStatsName

enum RangedWeaponStatsName {
	ACCURACY,
	SHOT_SPEED,
	ORBIT_SPEED,
	BULLET_COUNT,
	SPREAD_ANGLE,
}

func _get_stats_name(selected_stat: RangedWeaponStatsName) -> Array[String]:
	match selected_stat:
		RangedWeaponStatsName.ACCURACY:
			return ["shoot_behavior","accuracy"]
		RangedWeaponStatsName.SHOT_SPEED:
			return ["shoot_behavior","shoot_delay"]
		RangedWeaponStatsName.BULLET_COUNT:
			return ["shoot_behavior","bullet_count"]
		RangedWeaponStatsName.SPREAD_ANGLE:
			return ["shoot_behavior","spread_angle"]
		RangedWeaponStatsName.ORBIT_SPEED:
			return ["movement_behavior","orbit_speed"]
		_:
			push_error("Invalid RangedWeaponStatsName value: " + str(selected_stat))
			return []

func apply(weapon: RandedWeapon):
	property = _get_stats_name(property_name)
	super._apply(weapon)
