extends Resource
class_name MonsterModifier

@export var bonus: float = 0.0
@export var property_name: Enums.MonsterStatsName
var property: String

func _init() -> void:
	property = Enums.getStatsName(property_name)

static func create(property_name: Enums.MonsterStatsName, bonus: float = 0.0) -> MonsterModifier:
	push_error("create() must be implemented by subclass!")
	return null
	
func apply(monster: Monster):
	push_error("apply() must be implemented by subclass!")
