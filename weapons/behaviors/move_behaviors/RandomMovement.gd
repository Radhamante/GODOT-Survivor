extends WeaponMovementBehavior
class_name RandomMovement

func update_movement(weapon: Area2D, delta: float) -> void:
	weapon.rotate(randf_range(0,2*PI))
