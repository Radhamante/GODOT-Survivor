extends MonsterModifier
class_name FlatMonsterModifier



static func create(_property_name: Enums.MonsterStatsName, bonus: float = 0.0) -> FlatMonsterModifier:
	var mod = FlatMonsterModifier.new()
	mod.property_name = _property_name
	mod.bonus = bonus
	return mod

func apply(monster: Monster):
	monster.stats[property] += bonus
