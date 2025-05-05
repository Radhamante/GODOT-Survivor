extends Weapon
class_name RangedWeapon

@export var bullet_modifiers: Array[Modifier] = []
@export var shoot_behavior: ShootBehavior
@export var movement_behavior: WeaponMovementBehavior


func apply_weapon_modifiers():
	for mod in weapon_modifiers:
		if mod.operation == "add":
			mod.apply(self)
	for mod in weapon_modifiers:
		if mod.operation == "multiply":
			mod.apply(self)
	for mod in weapon_modifiers:
		if mod.operation == "set":
			mod.apply(self)

func add_modifier(modifier: Modifier):
	if modifier.modifier_target_type == "BULLET":
		bullet_modifiers.push_back(modifier)
	else:
		weapon_modifiers.push_back(modifier)

func _process(delta: float) -> void:
	if shoot_behavior:
		shoot_behavior.shoot(self, delta)


func _physics_process(delta: float) -> void:
	if movement_behavior:
		movement_behavior.update_movement(self, delta)
