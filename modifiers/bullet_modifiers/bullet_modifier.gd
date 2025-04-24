extends Resource
class_name BulletModifier

@export var bonus: float = 0.0
@export var property_name: ModifiedPropertyEnum
@export_enum("add", "multiply", "set") var operation := "add"

var property: Array[String]


enum ModifiedPropertyEnum {
	DAMAGE,
	ARMOR_PENETRATION,
	CRIT_CHANCE,
	CRIT_DAMAGE,
	TYPES,
	DAMAGE_REDUCTION_ON_PIERCING,
	KNOCKBACK_FORCE,
	SPEED,
	RANGE,
	PIERCING
}

func _get_stats_name(selected_stat: ModifiedPropertyEnum) -> Array[String]:
	match selected_stat:
		ModifiedPropertyEnum.DAMAGE:
			return ["damageSource","damage"]
		ModifiedPropertyEnum.ARMOR_PENETRATION:
			return ["damageSource","armor_penetration"]
		ModifiedPropertyEnum.CRIT_CHANCE:
			return ["damageSource","crit_chance"]
		ModifiedPropertyEnum.CRIT_DAMAGE:
			return ["damageSource","crit_damage"]
		ModifiedPropertyEnum.TYPES:
			return ["damageSource","types"]
		ModifiedPropertyEnum.DAMAGE_REDUCTION_ON_PIERCING:
			return ["damageSource","damage_reduction_on_piercing"]
		ModifiedPropertyEnum.KNOCKBACK_FORCE:
			return ["damageSource","knockback_force"]
		ModifiedPropertyEnum.SPEED:
			return ["bulletStats","speed"]
		ModifiedPropertyEnum.RANGE:
			return ["bulletStats","range"]
		ModifiedPropertyEnum.PIERCING:
			return ["bulletStats","piercing"]
		_:
			push_error("Invalid selected_stat value: " + str(selected_stat))
			return []


func apply(bullet: Bullet):
	property = _get_stats_name(property_name)
	
	if property.is_empty():
		push_error("No valid property path to apply modifier.")
		return

	var current = bullet
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
