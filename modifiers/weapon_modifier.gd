extends Resource
class_name WeaponModifier

@export var bonus: float = 0.0
@export_enum("add", "multiply", "set") var operation := "add"

var property: Array[String]


func _apply(weapon: Variant):
	
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
			if current is Array:
				current.set(final_key, current_value.push_back(bonus))
			else:
				current.set(final_key, current_value + bonus)
		"multiply":
			current.set(final_key, current_value * bonus)
		"set":
			current.set(final_key, bonus)
