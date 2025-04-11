class_name Weapon
extends Area2D

var weapon_modifiers:Array[WeaponModifier] = []
var bullet_modifiers: Array[BulletModifier] = []

func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() == 0:
		return

	var closest_enemy = null
	var closest_distance = INF

	for enemy in enemies_in_range:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy

	if closest_enemy:
		look_at(closest_enemy.global_position)
