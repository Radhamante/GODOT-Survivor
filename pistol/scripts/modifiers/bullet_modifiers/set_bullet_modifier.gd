extends BulletModifier
class_name SetBulletModifier

var bonus: Variant
var property: String

func _init(property: String, bonus: Variant):
	self.bonus = bonus
	self.property = property


func apply(bullet: Bullet):
	bullet[property] = bonus
