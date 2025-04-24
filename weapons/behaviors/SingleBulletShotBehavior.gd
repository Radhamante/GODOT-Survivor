extends ShootBehavior
class_name SingleBulletShootBehavior

@export var bullet_scene: PackedScene
@export_range(-180, 180) var accuracy_correction: float = 0

var accuracy: float = 0
var shoot_delay: float = 0.5
var shoot_timer: float = 0.0

func shoot(weapon: RandedWeapon, delta: float) -> void:
	shoot_timer += delta
	
	accuracy = 0
	shoot_delay = 0.5
	weapon.apply_weapon_modifiers()

	if shoot_timer >= shoot_delay:
		shoot_timer = 0.0

		var bullet:Bullet = bullet_scene.instantiate()

		var accuracy_bias = 0.7
		var random_offset = randf_range(0.0, 1.0)
		var log_weighted_offset = sign(random_offset - 0.5) * log(1.0 + abs(random_offset - 0.5)) * accuracy_bias
		var final_accuracy = log_weighted_offset * accuracy

		for effect in weapon.hit_effects:
			bullet.hit_effects.push_back(effect.duplicate(true))
		weapon.apply_bullet_modifier(bullet)

		bullet.global_position = weapon.get_node("%ShootingPoint").global_position
		bullet.global_rotation_degrees = weapon.get_node("%ShootingPoint").global_rotation_degrees + accuracy_correction + final_accuracy
		weapon.get_node("%ShootingPoint").add_child(bullet)
