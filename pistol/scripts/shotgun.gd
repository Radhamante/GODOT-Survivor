extends Weapon

func shoot():
	const SHOTGUN_BULLET = preload("res://pistol/scenes/shotgun_bullet.tscn")
	
	var bullets: Array[Area2D] = [
		SHOTGUN_BULLET.instantiate(),
		SHOTGUN_BULLET.instantiate(),
		SHOTGUN_BULLET.instantiate(),
		SHOTGUN_BULLET.instantiate(),
	]
		
	for i in range(bullets.size()):
		bullets[i].global_position = %ShootingPoints.get_child(i).global_position
		bullets[i].global_rotation_degrees = %ShootingPoints.get_child(i).global_rotation_degrees + 65 + 10 * i
		%ShootingPoints.add_child(bullets[i])
	
	
