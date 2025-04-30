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

func _init() -> void:
	call_deferred("setup")

func setup() -> void:
	var operation_icon: String
	match operation:
		"add":
			operation_icon = "+" if bonus.Float_value >= 0 else "-"
		"multiply":
			operation_icon = "*"
		"set":
			operation_icon = "="
	match property_name:
		MeleeWeaponStatsName.DAMAGE:
			property = ["damage_source","damage"]
			display_logo = preload("res://modifiers/sprites/damage.png")
			display_value = "Damage : " + operation_icon + str(abs(bonus.Float_value))
		MeleeWeaponStatsName.ARMOR_PENETRATION:
			property = ["damage_source","armor_penetration"]
			display_logo = preload("res://modifiers/sprites/armor_penetration.png")
			display_value = "Armor penetration : " + operation_icon + str(abs(bonus.Float_value))
		MeleeWeaponStatsName.CRIT_CHANCE:
			property = ["damage_source","crit_chance"]
			display_logo = preload("res://modifiers/sprites/crit_chance.png")
			display_value = "Critical hit chances : " + operation_icon + str(abs(bonus.Float_value*100)) + "%"
		MeleeWeaponStatsName.CRIT_DAMAGE:
			property = ["damage_source","crit_damage"]
			display_logo = preload("res://modifiers/sprites/crit_damage.png")
			display_value = "Cricital hit damages : " + operation_icon + str(abs(bonus.Float_value))
		MeleeWeaponStatsName.KNOCKBACK_FORCE:
			property = ["damage_source","knockback_force"]
			display_logo = preload("res://modifiers/sprites/hexagon.png")
			display_value = "Knockback : " + operation_icon + str(abs(bonus.Float_value))
		MeleeWeaponStatsName.ORBIT_SPEED:
			property = ["movement_behavior","orbit_speed"]
			display_logo = preload("res://modifiers/sprites/orbit_speed.png")
			display_value = "Orbit speed : " + operation_icon + str(abs(bonus.Float_value))
		_:
			push_error("Invalid MeleeWeaponStatsName value: " + str(property_name))
			property = []

func apply(weapon: MeleeWeapon):
	super._apply(weapon)
