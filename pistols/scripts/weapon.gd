class_name Weapon
extends Area2D

var weapon_modifiers:Array[WeaponModifier] = []
var bullet_modifiers: Array[BulletModifier] = []


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

func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() == 0:
		return

	var closest_enemy = null
	var closest_distance = INF

	for enemy in enemies_in_range:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy

	if closest_enemy:
		look_at(closest_enemy.get_node("CollisionShape2D").global_position)
