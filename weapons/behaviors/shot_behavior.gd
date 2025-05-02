extends Resource
class_name ShootBehavior

@export var bullet_scene: PackedScene
@export_range(-180, 180) var accuracy_correction: float = 0

@export var bullet_count: int = 1
var base_bullet_count: int

@export var spread_angle: float = 0.0 
var base_spread_angle: float

@export var shoot_delay: float = 0.5
var base_shoot_delay: float

@export var accuracy: float = 0
var base_accuracy: float

var accuracy_bias: float = 0.7
var shoot_timer: float = 0.0

func _init() -> void:
	call_deferred("setup")
	
func setup() -> void:
	base_shoot_delay = shoot_delay
	base_accuracy = accuracy
	base_bullet_count = bullet_count
	base_spread_angle = spread_angle

func shoot(weapon: RangedWeapon, delta: float) -> void:
	shoot_timer += delta
	
	if shoot_timer < shoot_delay:
		return
	shoot_timer = 0.0
		
	accuracy = base_accuracy
	shoot_delay = base_shoot_delay
	bullet_count = base_bullet_count
	spread_angle = base_spread_angle
	weapon.apply_weapon_modifiers()

	var base_position = weapon.get_node("%ShootingPoint").global_position
	var base_angle = weapon.get_node("%ShootingPoint").global_rotation_degrees
	
	for i in range(bullet_count):
		var bullet:Bullet = bullet_scene.instantiate()
		bullet.setup(weapon.bullet_modifiers)

		var random_bias = pow(randf(), 2) 
		var direction = -1 if randf() < 0.5 else 1 
		var final_accuracy = direction * random_bias * (accuracy/2)

		var spread_offset = -spread_angle / 2 + (i * (spread_angle / max(1, bullet_count - 1))) 
		var total_rotation = base_angle + accuracy_correction + spread_offset + final_accuracy

		bullet.global_position = base_position
		bullet.global_rotation_degrees = total_rotation

		bullet.hit_effects = weapon.hit_effects.duplicate()

		weapon.get_node("%ShootingPoint").add_child(bullet)
