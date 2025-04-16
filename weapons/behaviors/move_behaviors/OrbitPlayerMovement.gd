extends WeaponMovementBehavior
class_name OrbitPlayerMovement

@export var orbit_speed: float = 3.0

func update_movement(weapon: Area2D, delta: float) -> void:
	weapon.rotate(orbit_speed*delta)
