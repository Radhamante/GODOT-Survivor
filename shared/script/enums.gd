extends Node

enum DamageType {
	PHYSICAL,
	FIRE,
	MAGICAL,
	CRITICAL,
	BLEED,
}

enum MonsterStatsName {
	HEALTH,
	SPEED,
	DAMAGE,
	ARMOR,
	KNOCKBACK_RESISTANCE
}

func getStatsName(selected_stat: MonsterStatsName) -> String:
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
		_:
			push_error("Invalid MonsterStatsName value: " + str(selected_stat))
			return ""
