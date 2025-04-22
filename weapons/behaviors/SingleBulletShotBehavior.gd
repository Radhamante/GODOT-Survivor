extends ShootBehavior
class_name SingleBulletShootBehavior

@export var bullet_scene: PackedScene
@export var shoot_delay: float = 0.5
@export_range(-180, 180) var accuracy_correction: float = 0
var shoot_timer: float = 0.0

func shoot(weapon: RandedWeapon) -> void:
	shoot_timer += weapon.get_process_delta_time()

	var mods = weapon.weapon_modifiers
	var final_delay = weapon.apply_weapon_modifiers(mods, weapon.apply_weapon_modifiers(mods, shoot_delay, FlatShotspeedModifier), MultShotspeedModifier)

	if shoot_timer >= final_delay:
		shoot_timer = 0.0

		var bullet:Bullet = bullet_scene.instantiate()

		var accuracy_bias = 0.7
		var flat_acc = weapon.apply_weapon_modifiers(mods, 0.0, FlatAccuracyModifier)
		var total_acc = weapon.apply_weapon_modifiers(mods, flat_acc, MultAccuracyModifier)
		var random_offset = randf_range(0.0, 1.0)
		var log_weighted_offset = sign(random_offset - 0.5) * log(1.0 + abs(random_offset - 0.5)) * accuracy_bias
		var final_accuracy = log_weighted_offset * total_acc

		for effect in weapon.hit_effects:
			bullet.hit_effects.push_back(effect.duplicate(true))

		weapon.apply_bullet_modifier(weapon.bullet_modifiers, bullet, FlatBulletModifier)
		weapon.apply_bullet_modifier(weapon.bullet_modifiers, bullet, MultBulletModifier)
		weapon.apply_bullet_modifier(weapon.bullet_modifiers, bullet, SetBulletModifier)
		weapon.apply_bullet_modifier(weapon.bullet_modifiers, bullet, ProcessBulletModifier)

		bullet.global_position = weapon.get_node("%ShootingPoint").global_position
		bullet.global_rotation_degrees = weapon.get_node("%ShootingPoint").global_rotation_degrees + accuracy_correction + final_accuracy
		weapon.get_node("%ShootingPoint").add_child(bullet)
