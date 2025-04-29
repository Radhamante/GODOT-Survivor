extends Resource
class_name WeaponModifier

@export var bonus: FloatOrBulletModifier
@export_enum("add", "multiply", "set") var operation := "add"

var property: Array[String]
var display_value: String
var display_logo: CompressedTexture2D

func _apply(weapon: Variant):
	
	if property.is_empty():
		push_error("No valid property path to apply modifier.")
		return
	
	match bonus.type_choice:
		"BulletModifier":
			match operation:
				"add":
					if bonus.BulletModifier_value not in weapon.bullet_modifiers:
						weapon.bullet_modifiers.push_back(bonus.BulletModifier_value)
				"set":
					weapon.bullet_modifiers = bonus.BulletModifier_value
		"Float":
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
					current.set(final_key, current_value + bonus.Float_value)
				"multiply":
					current.set(final_key, current_value * bonus.Float_value)
				"set":
					current.set(final_key, bonus.Float_value)
