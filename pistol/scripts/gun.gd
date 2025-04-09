extends Weapon

func shoot():
	const GUN_BULLET = preload("res://pistol/scenes/gun_bullet.tscn")
	var new_bullet = GUN_BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation_degrees = %ShootingPoint.global_rotation_degrees - 37
	
	%ShootingPoint.add_child(new_bullet)
