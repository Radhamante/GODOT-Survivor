extends Resource
class_name BulletModifier

@export var bonus: float = 0.0
@export var property_name: ModifiedPropertyEnum
@export_enum("add", "multiply", "set") var operation := "add"

var property: Array[String]
var display_value: String
var display_logo: CompressedTexture2D

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

func _init() -> void:
	call_deferred("setup")

func setup() -> void:
	var operation_icon: String
	match operation:
		"add":
			operation_icon = "+" if bonus >= 0 else "-"
		"multiply":
			operation_icon = "*"
		"set":
			operation_icon = "="
	match property_name:
		ModifiedPropertyEnum.DAMAGE:
			property = ["damageSource","damage"]
			display_logo = preload("res://modifiers/sprites/damage.png")
			display_value = "Damage : "  + operation_icon + str(abs(bonus))
		ModifiedPropertyEnum.ARMOR_PENETRATION:
			property = ["damageSource","armor_penetration"]
			display_logo = preload("res://modifiers/sprites/armor_penetration.png")
			display_value = "Armore penetration"  + operation_icon + str(abs(bonus))
		ModifiedPropertyEnum.CRIT_CHANCE:
			property = ["damageSource","crit_chance"]
			display_logo = preload("res://modifiers/sprites/crit_chance.png")
			display_value = "Critical hit chances"  + operation_icon + str(abs(bonus*100)) + "%"
		ModifiedPropertyEnum.CRIT_DAMAGE:
			property = ["damageSource","crit_damage"]
			display_logo = preload("res://modifiers/sprites/crit_damage.png")
			display_value = "Critical damages multiplier"  + operation_icon + str(abs(bonus))
		ModifiedPropertyEnum.TYPES:
			property = ["damageSource","types"]
			display_logo = preload("res://modifiers/sprites/damage_type.png")
			display_value = "Damage type : "  + operation_icon + str(abs(bonus))
		ModifiedPropertyEnum.DAMAGE_REDUCTION_ON_PIERCING:
			property = ["damageSource","damage_reduction_on_piercing"]
			display_logo = preload("res://modifiers/sprites/hexagon.png")
			display_value = "Piercing damage reduction"  + operation_icon + str(abs(bonus))
		ModifiedPropertyEnum.KNOCKBACK_FORCE:
			property = ["damageSource","knockback_force"]
			display_logo = preload("res://modifiers/sprites/hexagon.png")
			display_value = "Knockback"  + operation_icon + str(abs(bonus))
		ModifiedPropertyEnum.SPEED:
			property = ["bulletStats","speed"]
			display_logo = preload("res://modifiers/sprites/bullet_speed.png")
			display_value = "Bullet speed"  + operation_icon + str(abs(bonus))
		ModifiedPropertyEnum.RANGE:
			property = ["bulletStats","range"]
			display_logo = preload("res://modifiers/sprites/hexagon.png")
			display_value = "Range"  + operation_icon + str(abs(bonus))
		ModifiedPropertyEnum.PIERCING:
			property = ["bulletStats","piercing"]
			display_logo = preload("res://modifiers/sprites/hexagon.png")
			display_value = "Piercing"  + operation_icon + str(abs(bonus))
		_:
			push_error("Invalid selected_stat value: " + str(property_name))
			


func apply(bullet: Bullet):
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
