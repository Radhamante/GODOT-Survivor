extends Resource
class_name WeaponModifier


func apply(prev: Variant) -> Variant:
	push_error("apply() must be implemented by subclass!")
	return null
