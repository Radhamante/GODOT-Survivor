extends Resource
class_name WeaponModifier

@export var bonus: float = 0.0
@export var property_name: WeaponStatsName
@export_enum("add", "multiply", "set") var operation := "add"

var property: Array[String]

enum WeaponStatsName {
	ACCURACY,
	SHOT_SPEED,
	ORBIT_SPEED,
	BULLET_COUNT,
	SPREAD_ANGLE,
}

func _get_stats_name(selected_stat: WeaponStatsName) -> Array[String]:
	match selected_stat:
		WeaponStatsName.ACCURACY:
			return ["shoot_behavior","accuracy"]
		WeaponStatsName.SHOT_SPEED:
			return ["shoot_behavior","shoot_delay"]
		WeaponStatsName.BULLET_COUNT:
			return ["shoot_behavior","bullet_count"]
		WeaponStatsName.SPREAD_ANGLE:
			return ["shoot_behavior","spread_angle"]
		WeaponStatsName.ORBIT_SPEED:
			return ["move_behavior","orbit_speed"]
		_:
			push_error("Invalid WeaponStatsName value: " + str(selected_stat))
			return []

func apply(weapon: RandedWeapon):
	property = _get_stats_name(property_name)
	
	if property.is_empty():
		push_error("No valid property path to apply modifier.")
		return

	var current = weapon
	for i in range(property.size() - 1):
		current = current.get(property[i])

	var final_key = property[-1]

	if not current.has_method("get") or not current.has_method("set"):
		push_error("Target object does not support get/set.")
		return

	var current_value = current.get(final_key)

	if typeof(current_value) == TYPE_NIL:
		push_warning("Property '%s' not found or nil on %s" % [final_key, str(current)])
		return

	match operation:
		"add":
			current.set(final_key, current_value + bonus)
		"multiply":
			current.set(final_key, current_value * bonus)
		"set":
			current.set(final_key, bonus)
