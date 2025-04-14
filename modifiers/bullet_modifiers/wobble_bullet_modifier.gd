extends ProcessBulletModifier
class_name WobbleBulletModifier

var timer = 0
var is_big = false

var base_scale
var base_damage

func callback(bullet: Bullet, delta: float):
	timer += delta
	if timer >= 0.1:
		timer = 0
		if is_big:
			bullet.scale = base_scale * .5
			bullet.damage = base_damage * .5
		else:
			bullet.scale = base_scale * 1.5
			bullet.damage = base_damage * 1.5
		is_big = !is_big

func apply(bullet: Bullet):
	base_scale = bullet.scale
	base_damage = bullet.damage
	bullet.process.push_back(callback)
