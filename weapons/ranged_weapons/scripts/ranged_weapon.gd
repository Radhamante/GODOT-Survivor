extends Area2D
class_name RandedWeapon

@export var weapon_modifiers:Array[WeaponModifier] = []
@export var bullet_modifiers: Array[BulletModifier] = []
@export var hit_effects: Array[EffectComponent] = []
@export var shoot_behavior: ShootBehavior
@export var movement_behavior: WeaponMovementBehavior


# Function to apply modifiers to a given value
func apply_weapon_modifiers(mods: Array[WeaponModifier], target_value: Variant, modifier_type) -> Variant:
	var result = target_value
	for mod in mods:
		if is_instance_of(mod,modifier_type):
			result = mod.apply(result)
	return result
	
func apply_bullet_modifier(mods: Array[BulletModifier], bullet: Bullet, modifier_type) -> Bullet:
	for mod in mods:
		if is_instance_of(mod,modifier_type):
			bullet = mod.apply(bullet)
	return bullet
	
func _process(delta: float) -> void:
	if shoot_behavior:
		shoot_behavior.shoot(self)


func _physics_process(delta: float) -> void:
	if movement_behavior:
		movement_behavior.update_movement(self, delta)
