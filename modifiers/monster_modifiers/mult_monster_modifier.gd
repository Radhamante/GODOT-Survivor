extends MonsterModifier
class_name MultMonsterModifier

static func create(_property_name: Enums.MonsterStatsName, _bonus: float = 0.0) -> MultMonsterModifier:
	var mod = MultMonsterModifier.new()
	mod.property = Enums.getStatsName(_property_name)
	mod.bonus = _bonus
	return mod

func apply(monster: Monster):
	monster.stats[property] *= bonus
