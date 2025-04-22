extends Node2D

func add_weapon(weapon: PackedScene):
	_instanciate_weapon(weapon)

func _instanciate_weapon(weapon: PackedScene):
	var instance = weapon.instantiate()
	if instance is RandedWeapon or instance is MeleeWeapon:
		add_child(instance)
