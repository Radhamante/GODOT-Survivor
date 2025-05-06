@tool
extends Resource
class_name Modifier

var modifier_target_types = [
	"BULLET",
	"MELEE",
	"RANGED"
]

var bullet_modifier_properties = {
	"DAMAGE" : {
		"property_path": ["damage_source","damage"],
		"display_logo": preload("res://modifiers/sprites/damage.png"),
		"display_value": "Damage ",
	},
	"ARMOR_PENETRATION" : {
		"property_path": ["damage_source","armor_penetration"],
		"display_logo": preload("res://modifiers/sprites/armor_penetration.png"),
		"display_value": "Armor penetration ",
	},
	"CRIT_CHANCE" : {
		"property_path": ["damage_source","crit_chance"],
		"display_logo": preload("res://modifiers/sprites/crit_chance.png"),
		"display_value": "Critical hit chances ",
	},
	"CRIT_DAMAGE" : {
		"property_path": ["damage_source","crit_damage"],
		"display_logo": preload("res://modifiers/sprites/crit_damage.png"),
		"display_value": "Critical damages multiplier ",
	},
	"TYPES" : {
		"property_path": ["damage_source","types"],
		"display_logo": preload("res://modifiers/sprites/damage_type.png"),
		"display_value": "Damage type ",
	},
	"DAMAGE_REDUCTION_ON_PIERCING" : {
		"property_path": ["damage_source","damage_reduction_on_piercing"],
		"display_logo": preload("res://modifiers/sprites/hexagon.png"),
		"display_value": "Piercing damage reduction ",
	},
	"KNOCKBACK_FORCE" : {
		"property_path": ["damage_source","knockback_force"],
		"display_logo": preload("res://modifiers/sprites/hexagon.png"),
		"display_value": "Knockback ",
	},
	"SPEED" : {
		"property_path": ["bulletStats","speed"],
		"display_logo": preload("res://modifiers/sprites/bullet_speed.png"),
		"display_value": "Bullet speed ",
		"display_value_sign_inverted": true,
		"display_value_suffix": "s"
	},
	"RANGE" : {
		"property_path": ["bulletStats","range"],
		"display_logo": preload("res://modifiers/sprites/hexagon.png"),
		"display_value": "Range ",
	},
	"PIERCING" : {
		"property_path": ["bulletStats","piercing"],
		"display_logo": preload("res://modifiers/sprites/hexagon.png"),
		"display_value": "Piercing ",
	},
	"HIT_EFFECT": {
		"property_path": ["hit_effects"],
		"display_logo": preload("res://modifiers/sprites/hexagon.png"),
		"display_value": "Hit effects ",
	},
}

var melee_weapon_modifier_properties = {
	"DAMAGE" : {
		"property_path": ["damage_source","damage"],
		"display_logo": preload("res://modifiers/sprites/damage.png"),
		"display_value": "Damage ",
	},
	"ARMOR_PENETRATION" : {
		"property_path": ["damage_source","armor_penetration"],
		"display_logo": preload("res://modifiers/sprites/armor_penetration.png"),
		"display_value": "Armor penetration ",
	},
	"CRIT_CHANCE" : {
		"property_path": ["damage_source","crit_chance"],
		"display_logo": preload("res://modifiers/sprites/crit_chance.png"),
		"display_value": "Critical hit chances ",
		"display_value_multiplier": 100,
		"display_value_suffix": "%" 
	},
	"CRIT_DAMAGE" : {
		"property_path": ["damage_source","crit_damage"],
		"display_logo": preload("res://modifiers/sprites/crit_damage.png"),
		"display_value": "Critical damages multiplier ",
		"display_value_suffix": "%" 
	},
	"TYPES" : {
		"property_path": ["damage_source","types"],
		"display_logo": preload("res://modifiers/sprites/damage_type.png"),
		"display_value": "Damage type ",
	},
	"KNOCKBACK_FORCE" : {
		"property_path": ["damage_source","knockback_force"],
		"display_logo": preload("res://modifiers/sprites/hexagon.png"),
		"display_value": "Knockback ",
	},
	"ORBIT_SPEED" : {
		"property_path": ["movement_behavior","orbit_speed"],
		"display_logo": preload("res://modifiers/sprites/orbit_speed.png"),
		"display_value": "Orbit speed ",
	},
	"HIT_EFFECT": {
		"property_path": ["hit_effects"],
		"display_logo": preload("res://modifiers/sprites/hexagon.png"),
		"display_value": "Hit effects ",
	},
}

var ranged_weapon_modifier_properties = {
	"ACCURACY": {
		"property_path":["shoot_behavior","accuracy"],
		"display_logo": preload("res://modifiers/sprites/hexagon.png"),
		"display_value": "Accuracy "
	},
	"SHOT_SPEED": {
		"property_path":["shoot_behavior","shoot_delay"],
		"display_logo": preload("res://modifiers/sprites/shoot_delay.png"),
		"display_value": "Shot delay ",
		"display_value_suffix": "s"
	},
	"ORBIT_SPEED": {
		"property_path":["shoot_behavior","orbit_speed"],
		"display_logo": preload("res://modifiers/sprites/bullet_count.png"),
		"display_value": "Orbit speed "
	},
	"BULLET_COUNT": {
		"property_path":["shoot_behavior","bullet_count"],
		"display_logo": preload("res://modifiers/sprites/hexagon.png"),
		"display_value": "bullet count "
	},
	"SPREAD_ANGLE": {
		"property_path":["movement_behavior","spread_angle"],
		"display_logo": preload("res://modifiers/sprites/orbit_speed.png"),
		"display_value": "Spread angle "
	},
}

@export_enum("add", "multiply", "set") var operation := "add"
var modifier_target_type: String:
	set(value):
		modifier_target_type = value
		modifier_property = null
		property_value = null
		notify_property_list_changed()
		
var modifier_property: Variant = null:
	set(value):
		modifier_property = value
		notify_property_list_changed()
		
var property_value: Variant = null

var display_value: String:
	get:
		var value = ""
		
		var property
		match modifier_target_type:
			"BULLET":
				property = bullet_modifier_properties[modifier_property]
			"RANGED":
				property = ranged_weapon_modifier_properties[modifier_property]
			"MELEE":
				property = melee_weapon_modifier_properties[modifier_property]
		
		var operation_icon: String
		match operation:
			"add":
				operation_icon = "+" if property_value is float or property_value is int and ((property_value >= 0) and (not "display_value_sign_inverted" in property)) else "-"
			"multiply":
				operation_icon = "*"
			"set":
				operation_icon = "="
				
		value = property.display_value
		value += operation_icon
		if property_value is float or property_value is int:
			value += str(abs(property_value * (property.display_value_multiplier if "display_value_multiplier" in property else 1 )))
		value += property.display_value_suffix if "display_value_suffix" in property else ""
		return value

var display_logo: CompressedTexture2D:
	get:
		match modifier_target_type:
			"BULLET":
				return bullet_modifier_properties[modifier_property].display_logo
			"RANGED":
				return ranged_weapon_modifier_properties[modifier_property].display_logo
			"MELEE":
				return melee_weapon_modifier_properties[modifier_property].display_logo
			_:
				push_error("invalid")
				return null
var property_path: Array[String]:
	get:
		match modifier_target_type:
			"BULLET":
				return bullet_modifier_properties[modifier_property].property_path
			"RANGED":
				return ranged_weapon_modifier_properties[modifier_property].property_path
			"MELEE":
				return melee_weapon_modifier_properties[modifier_property].property_path
			_:
				push_error("invalid")
				return [""]
				

func _init() -> void:
	notify_property_list_changed()

func _get_property_list():	
	var props = []
	
	props.append({
		"name": "modifier_target_type",
		"type": TYPE_STRING,
		"usage": PROPERTY_USAGE_DEFAULT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(modifier_target_types) ,
	})

	match modifier_target_type:
		"BULLET":
			props.append({
				"name": "modifier_property",
				"type": TYPE_STRING,
				"usage": PROPERTY_USAGE_DEFAULT,
				"hint": PROPERTY_HINT_ENUM,
				"hint_string": ",".join(bullet_modifier_properties.keys()) ,
			})
		"MELEE":
			props.append({
				"name": "modifier_property",
				"type": TYPE_STRING,
				"usage": PROPERTY_USAGE_DEFAULT,
				"hint": PROPERTY_HINT_ENUM,
				"hint_string": ",".join(melee_weapon_modifier_properties.keys())
			})
		"RANGED":
			props.append({
				"name": "modifier_property",
				"type": TYPE_STRING,
				"usage": PROPERTY_USAGE_DEFAULT,
				"hint": PROPERTY_HINT_ENUM,
				"hint_string": ",".join(ranged_weapon_modifier_properties.keys())
			})
	
	match modifier_property:
		"PIERCING":
			props.append({
				"name": "property_value",
				"type": TYPE_BOOL,
				"usage": PROPERTY_USAGE_DEFAULT,
			})	
		"TYPES":
			props.append({
				"name": "property_value",
				"type": TYPE_INT,
				"usage": PROPERTY_USAGE_DEFAULT,
				"hint": PROPERTY_HINT_ENUM,
				"hint_string": "PHYSICAL,
								FIRE,
								MAGICAL,
								CRITICAL,
								BLEED"
			})	
		"HIT_EFFECT":
			props.append({
				"name": "property_value",
				"type": TYPE_OBJECT,
				"hint": PROPERTY_HINT_RESOURCE_TYPE,
				"hint_string": "EffectComponent",
				"usage": PROPERTY_USAGE_DEFAULT,
			})	
		_:
			props.append({
				"name": "property_value",
				"type": TYPE_FLOAT,
				"usage": PROPERTY_USAGE_DEFAULT,
			})

	return props


func apply(targeted_element: Variant):

	var current = targeted_element
	
	var properties
	match modifier_target_type:
		"BULLET":
			properties = bullet_modifier_properties[modifier_property].property_path
		"RANGED":
			properties = ranged_weapon_modifier_properties[modifier_property].property_path
		"MELEE":
			properties = melee_weapon_modifier_properties[modifier_property].property_path
	
	for i in range(properties.size() - 1):
		current = current.get(properties[i])

	var final_key = properties[-1]

	if not current.has_method("get") or not current.has_method("set"):
		push_error("Target object does not support get/set.")
		return

	var current_value = current.get(final_key)

	if typeof(current_value) == TYPE_NIL:
		push_warning("Property '%s' not found or nil on %s" % [final_key, str(current)])
		return

	match operation:
		"add":
			if current[final_key] is Array:
				current_value.push_back(property_value)
			else:
				current.set(final_key, current_value + property_value)
		"multiply":
			if current is Array:
				push_error("Can't multiply an array")
			else:
				current.set(final_key, current_value * property_value)
		"set":
			if current is Array:
				current.set(final_key, [property_value])
			else:
				current.set(final_key, property_value)
