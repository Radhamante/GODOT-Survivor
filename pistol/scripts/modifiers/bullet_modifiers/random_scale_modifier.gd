extends BulletModifier
class_name RandomScaleModifier

var bonus: float = 0.0
var min: float
var max: float

func _init(min:float, max: float):
	self.min = min
	self.max = max


func apply(bullet: Bullet):
	bullet.scale *= randf_range(min, max)
