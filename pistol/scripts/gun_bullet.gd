extends Bullet

func _init() -> void:
	damage = 2
	crit_chance = .5
	piercing = true
	
func get_piercing_damage_reduction() -> float: 
	return damage / 2
