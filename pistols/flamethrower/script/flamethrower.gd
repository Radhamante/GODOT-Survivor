extends Weapon

const FLAMETHROWER_BULLET = preload("res://pistols/flamethrower/scene/flamethrower_bullet.tscn")

var shoot_timer : float = 0.0  # Internal timer for delay between shots
var shoot_delay : float = 0.05   # Initial delay between shots (in seconds)

func _ready() -> void:
	pass

# Handle shooting logic (called each frame)
func _process(delta: float) -> void:
	shoot_timer += delta

	# Check if we can shoot (timer has reached shotspeed)
	var shotspeed = apply_weapon_modifiers(weapon_modifiers, apply_weapon_modifiers(weapon_modifiers, shoot_delay, FlatShotspeedModifier), MultShotspeedModifier)
	if shoot_timer >= shotspeed:
		shoot()
		shoot_timer = 0
		
func shoot():
	var new_bullet = FLAMETHROWER_BULLET.instantiate()
	new_bullet.scale = Vector2.ONE * randf_range(1,2)
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation_degrees = %ShootingPoint.global_rotation_degrees - 90 + randf_range(-20,20)
	
	%ShootingPoint.add_child(new_bullet)
