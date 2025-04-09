extends Bullet

func _ready() -> void:
	damage = 2
	piercing = true
	
func get_piercing_damage_reduction() -> float: 
	return damage / 2
