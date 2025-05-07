extends EffectComponent
class_name BoucingBulletEffect

@export var bounce_radius: float = 300.0
@export var max_bouce: int = 3
var current_bouce_time = 0

func reset():
	current_bouce_time = 0

func apply(caller: Variant, monster: Monster) -> void:
	if caller is not Bullet:
		return
	if current_bouce_time >= max_bouce:
		caller.queue_free()
		return
		
	var bullet: Bullet = caller

	var area := Area2D.new()
	var shape := CircleShape2D.new()
	shape.radius = bounce_radius

	var collision_shape := CollisionShape2D.new()
	collision_shape.shape = shape
	area.add_child(collision_shape)
	bullet.add_child(area)

	area.set_collision_mask_value(2, true)
	area.set_collision_mask_value(1, false)
	area.set_collision_layer_value(1, false)

	await bullet.get_tree().process_frame
	await bullet.get_tree().process_frame

	var enemies = area.get_overlapping_bodies()
	if enemies.is_empty():
		bullet.queue_free()
		area.queue_free()
		return

	var closest: Node2D = null
	var closest_dist := INF

	for e in enemies:
		if not e is Node2D or e == monster:
			continue
		var dist = bullet.global_position.distance_to(e.global_position)
		if dist < closest_dist:
			closest_dist = dist
			closest = e

	if closest:
		bullet.look_at(closest.get_node("CollisionShape2D").global_position)
		current_bouce_time += 1
	else:
		bullet.queue_free()

	area.queue_free()
