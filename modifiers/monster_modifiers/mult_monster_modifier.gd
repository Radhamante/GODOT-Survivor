extends MonsterModifier
class_name MultMonsterModifier

var bonus: float = 0.0
var property: String

func _init(property: String, bonus: float = 0.0):
	self.bonus = bonus
	self.property = property


func apply(monster: Monster):
	if not monster.stats.has_meta(property):
		push_error("Unkown property of monster : ", property)
		return
	monster.stats[property] *= bonus
