extends WeaponModifier
class_name RangedWeaponModifier

@export var property_name: RangedWeaponStatsName

enum RangedWeaponStatsName {
	ACCURACY,
	SHOT_SPEED,
	ORBIT_SPEED,
	BULLET_COUNT,
	SPREAD_ANGLE,
	BULLET_MODIFIERS,
}

func _init() -> void:
	call_deferred("setup")

func setup() -> void:
	var operation_icon: String
	match operation:
		"add":
			if property_name == RangedWeaponStatsName.ACCURACY:
				operation_icon = "-" if bonus.Float_value >= 0 else "+"
			else:
				operation_icon = "+" if bonus.Float_value >= 0 else "-"
		"multiply":
			operation_icon = "*"
		"set":
			operation_icon = "="
	match property_name:
		RangedWeaponStatsName.ACCURACY:
			property = ["shoot_behavior","accuracy"]
			display_logo = preload("res://modifiers/sprites/hexagon.png")
			display_value = "Accuracy : " + operation_icon + str(abs(bonus.Float_value))
		RangedWeaponStatsName.SHOT_SPEED:
			property = ["shoot_behavior","shoot_delay"]
			display_logo = preload("res://modifiers/sprites/shoot_delay.png")
			display_value = "Shot delay : " + operation_icon + "seconds"
		RangedWeaponStatsName.BULLET_COUNT:
			property = ["shoot_behavior","bullet_count"]
			display_logo = preload("res://modifiers/sprites/bullet_count.png")
			display_value = "Bullet count : " + operation_icon + str(abs(bonus.Float_value)) 
		RangedWeaponStatsName.SPREAD_ANGLE:
			property = ["shoot_behavior","spread_angle"]
			display_logo = preload("res://modifiers/sprites/hexagon.png")
			display_value = "Spread angle : " + operation_icon + str(abs(bonus.Float_value))
		RangedWeaponStatsName.ORBIT_SPEED:
			property = ["movement_behavior","orbit_speed"]
			display_logo = preload("res://modifiers/sprites/orbit_speed.png")
			display_value = "Orbit speed : " + operation_icon + str(abs(bonus.Float_value))
		RangedWeaponStatsName.BULLET_MODIFIERS:
			property = ["bullet_modifiers"]
			display_logo = bonus.BulletModifier_value.display_logo
			display_value = bonus.BulletModifier_value.display_value
		_:
			push_error("Invalid RangedWeaponStatsName value: " + str(property_name))
			property = []

func apply(weapon: RandedWeapon):
	super._apply(weapon)
