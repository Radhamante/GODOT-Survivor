extends Resource
class_name FloatOrBulletModifier

@export_enum("Float", "BulletModifier") var type_choice: String
@export var Float_value: float
@export var BulletModifier_value: BulletModifier

func get_value():
	match type_choice:
		"Float":
			return Float_value
		"BulletModifier":
			return BulletModifier_value
