extends Weapon

var shoot_timer : float = 0.0  # Internal timer for delay between shots
var shoot_delay : float = 0.7   # Initial delay between shots (in seconds)

func _ready() -> void:
	weapon_modifiers.push_back(FlatAccuracyModifier.new(30))

# Handle shooting logic (called each frame)
func _process(delta: float) -> void:
	shoot_timer += delta

	# Check if we can shoot (timer has reached shotspeed)
	var shotspeed = apply_weapon_modifiers(weapon_modifiers, apply_weapon_modifiers(weapon_modifiers, shoot_delay, FlatShotspeedModifier), MultShotspeedModifier)
	if shoot_timer >= shotspeed:
		shoot()
		shoot_timer = 0


func shoot():
	const SHOTGUN_BULLET = preload("res://pistols/shotgun/scene/shotgun_bullet.tscn")
	var bullets: Array[Area2D] = [
		SHOTGUN_BULLET.instantiate(),
		SHOTGUN_BULLET.instantiate(),
		SHOTGUN_BULLET.instantiate(),
		SHOTGUN_BULLET.instantiate(),
	]
		
	for i in range(bullets.size()):
		var new_bullet = bullets[i]
		
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
		new_bullet.global_position = %ShootingPoints.get_child(i).global_position
		new_bullet.global_rotation_degrees = %ShootingPoints.get_child(i).global_rotation_degrees + 90 + (5*i) + final_accuracy
		%ShootingPoints.get_child(i).add_child(new_bullet)
	
	
