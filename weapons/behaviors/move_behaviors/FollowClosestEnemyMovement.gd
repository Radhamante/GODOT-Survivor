extends WeaponMovementBehavior
class_name FollowClosestEnemyMovement

func update_movement(weapon: Weapon, delta: float) -> void:
	var enemies_in_range = weapon.get_overlapping_bodies()
	if enemies_in_range.is_empty():
		return

	var closest = null
	var closest_dist = INF

	for e in enemies_in_range:
		if not e is Node2D:
			continue
		var dist = weapon.global_position.distance_to(e.global_position)
		if dist < closest_dist:
			closest_dist = dist
			closest = e

	if closest:
		var target_pos = closest.get_node("CollisionShape2D").global_position
		weapon.look_at(target_pos)
