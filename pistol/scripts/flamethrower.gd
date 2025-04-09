extends Weapon


func shoot():
	const FLAMETHROWER_BULLET = preload("res://pistol/scenes/flamethrower_bullet.tscn")
	var new_bullet = FLAMETHROWER_BULLET.instantiate()
	new_bullet.scale = Vector2.ONE * randf_range(1,2)
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation_degrees = %ShootingPoint.global_rotation_degrees - 90 + randf_range(-20,20)
	
	%ShootingPoint.add_child(new_bullet)
