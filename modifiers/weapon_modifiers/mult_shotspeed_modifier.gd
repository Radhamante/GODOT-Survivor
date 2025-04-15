extends WeaponModifier
class_name MultShotspeedModifier

@export var bonus: float = 0.0


func _init(bonus: float = 0.0):
	self.bonus = bonus


func apply(prev: Variant) -> Variant:
	return prev / bonus
