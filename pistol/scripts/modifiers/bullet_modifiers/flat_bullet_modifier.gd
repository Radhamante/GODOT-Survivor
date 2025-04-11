extends BulletModifier
class_name FlatBulletModifier

var bonus: float = 0.0
var property: String

func _init(property: String, bonus: float = 0.0):
	self.bonus = bonus
	self.property = property


func apply(bullet: Bullet):
	bullet[property] += bonus
