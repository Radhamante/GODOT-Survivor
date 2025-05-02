extends Resource
class_name MonsterModifier

@export var bonus: float = 0.0
@export var property_name: MonsterStatsName
@export var operation :operation_enum = operation_enum.add

var property: String

enum operation_enum {add, multiply, set}
enum MonsterStatsName {
	HEALTH,
	SPEED,
	DAMAGE,
	ARMOR,
	KNOCKBACK_RESISTANCE,
	XP
}

func _get_stats_name(selected_stat: MonsterStatsName) -> String:
	match selected_stat:
		MonsterStatsName.HEALTH:
			return "health"
		MonsterStatsName.SPEED:
			return "speed"
		MonsterStatsName.DAMAGE:
			return "damage"
		MonsterStatsName.ARMOR:
			return "armor"
		MonsterStatsName.KNOCKBACK_RESISTANCE:
			return "knockback_resistance"
		MonsterStatsName.XP:
			return "xp_drop"
		_:
			push_error("Invalid MonsterStatsName value: " + str(selected_stat))
			return ""


func _init() -> void:
	property = _get_stats_name(property_name)
	
static func create(_property_name: MonsterStatsName, _bonus: float = 0.0, _operation: operation_enum = operation_enum.add) -> MonsterModifier:
	var mod = MonsterModifier.new()
	mod.property = mod._get_stats_name(_property_name)
	mod.bonus = _bonus
	mod.operation = _operation
	return mod

func apply(monster: Monster):
	match operation:
		operation_enum.add:
			monster.stats[property] += bonus
		operation_enum.multiply:
			monster.stats[property] *= bonus
		operation_enum.set:
			monster.stats[property] = bonus
			
