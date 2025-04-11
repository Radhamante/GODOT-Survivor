extends Weapon

var shoot_timer : float = 0.0  # Internal timer for delay between shots
var shoot_delay : float = 0.5   # Initial delay between shots (in seconds)

func _ready() -> void:
	pass

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

# Handle shooting logic (called each frame)
func _process(delta: float) -> void:
	shoot_timer += delta

	# Check if we can shoot (timer has reached shotspeed)
	var shotspeed = apply_weapon_modifiers(weapon_modifiers, apply_weapon_modifiers(weapon_modifiers, shoot_delay, FlatShotspeedModifier), MultShotspeedModifier)
	if shoot_timer >= shotspeed:
		shoot()
		shoot_timer = 0

# Shooting function
func shoot():
	const GUN_BULLET = preload("res://pistol/scenes/gun_bullet.tscn")
	var new_bullet = GUN_BULLET.instantiate()
	
	# APPLYING ACCURACY MODIFIERS
	var accuracy_bias = .7
	var flat_accuracy_modifier = apply_weapon_modifiers(weapon_modifiers, 0.0, FlatAccuracyModifier)
	var total_accuracy_modifier = apply_weapon_modifiers(weapon_modifiers, flat_accuracy_modifier, MultAccuracyModifier)
	var random_offset = randf_range(0.0, 1.0)
	var log_weighted_offset = sign(random_offset - 0.5) * log(1.0 + abs(random_offset - 0.5)) * accuracy_bias
	var final_accuracy = log_weighted_offset * total_accuracy_modifier
	
	apply_bullet_modifier(bullet_modifiers, new_bullet, FlatBulletModifier)
	apply_bullet_modifier(bullet_modifiers, new_bullet, MultBulletModifier)
	apply_bullet_modifier(bullet_modifiers, new_bullet, SetBulletModifier)
	apply_bullet_modifier(bullet_modifiers, new_bullet, ProcessBulletModifier)
	
	# POSITION AND ROTATION
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation_degrees = %ShootingPoint.global_rotation_degrees - 37 + final_accuracy
	%ShootingPoint.add_child(new_bullet)
