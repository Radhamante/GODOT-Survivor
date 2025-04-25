extends Resource
class_name ShootBehavior

@export var bullet_scene: PackedScene
@export var bullet_count: int = 1
@export var spread_angle: float = 0.0  # Total angle covered by spread
@export_range(-180, 180) var accuracy_correction: float = 0

var accuracy_bias: float = 0.7
var accuracy: float = 0
var shoot_delay: float = 0.5
var shoot_timer: float = 0.0

func shoot(weapon: RandedWeapon, delta: float) -> void:
	shoot_timer += delta
	
	accuracy = 0
	shoot_delay = 0.5
	weapon.apply_weapon_modifiers()
	
	if shoot_timer < shoot_delay:
		return
	
	shoot_timer = 0.0

	var base_position = weapon.get_node("%ShootingPoint").global_position
	var base_angle = weapon.get_node("%ShootingPoint").global_rotation_degrees + accuracy_correction
	
	for i in range(bullet_count):
		var bullet:Bullet = bullet_scene.instantiate()

		var random_offset = randf_range(0.0, 1.0)
		var log_weighted_offset = sign(random_offset - 0.5) * log(1.0 + abs(random_offset - 0.5)) * accuracy_bias
		var final_accuracy = log_weighted_offset * accuracy

		var spread_offset = -spread_angle / 2 + (i * (spread_angle / max(1, bullet_count - 1)))
		var total_rotation = base_angle + spread_offset + final_accuracy

		bullet.global_position = base_position
		bullet.global_rotation_degrees = total_rotation

		bullet.hit_effects = weapon.hit_effects.duplicate()

		weapon.get_node("%ShootingPoint").add_child(bullet)
