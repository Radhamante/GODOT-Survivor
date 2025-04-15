extends ShootBehavior
class_name MultipleBulletShootBehavior

@export var bullet_scene: PackedScene
@export var shoot_delay: float = 0.7
@export var bullet_count: int = 4
@export var spread_angle: float = 25.0  # Total angle covered by spread
@export var accuracy_bias: float = 0.7
@export_range(-180, 180) var accuracy_correction: float = 0


var shoot_timer: float = 0.0

func shoot(weapon: Weapon) -> void:
	shoot_timer += weapon.get_process_delta_time()
	var mods = weapon.weapon_modifiers
	var final_delay = weapon.apply_weapon_modifiers(mods, weapon.apply_weapon_modifiers(mods, shoot_delay, FlatShotspeedModifier), MultShotspeedModifier)

	if shoot_timer < final_delay:
		return
	
	shoot_timer = 0.0

	var base_position = weapon.get_node("%ShootingPoint").global_position
	var base_angle = weapon.get_node("%ShootingPoint").global_rotation_degrees + accuracy_correction
	
	for i in range(bullet_count):
		var bullet:Bullet = bullet_scene.instantiate()

		var flat_accuracy = weapon.apply_weapon_modifiers(mods, 0.0, FlatAccuracyModifier)
		var total_accuracy = weapon.apply_weapon_modifiers(mods, flat_accuracy, MultAccuracyModifier)

		var random_offset = randf_range(0.0, 1.0)
		var log_weighted_offset = sign(random_offset - 0.5) * log(1.0 + abs(random_offset - 0.5)) * accuracy_bias
		var final_accuracy = log_weighted_offset * total_accuracy

		var spread_offset = -spread_angle / 2 + (i * (spread_angle / max(1, bullet_count - 1)))
		var total_rotation = base_angle + spread_offset + final_accuracy

		bullet.global_position = base_position
		bullet.global_rotation_degrees = total_rotation

		bullet.hit_effects = weapon.hit_effects.duplicate()

		weapon.apply_bullet_modifier(weapon.bullet_modifiers, bullet, FlatBulletModifier)
		weapon.apply_bullet_modifier(weapon.bullet_modifiers, bullet, MultBulletModifier)
		weapon.apply_bullet_modifier(weapon.bullet_modifiers, bullet, SetBulletModifier)
		weapon.apply_bullet_modifier(weapon.bullet_modifiers, bullet, ProcessBulletModifier)

		weapon.get_node("%ShootingPoint").add_child(bullet)
