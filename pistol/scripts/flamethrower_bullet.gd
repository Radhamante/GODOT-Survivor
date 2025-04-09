extends Bullet

var time_to_zero = 1.0
var opacity = 1.0

func _physics_process(delta: float) -> void:
	if speed > 0.0:
		var deceleration = speed / time_to_zero
		speed -= deceleration * delta
	super._physics_process(delta)

func _ready() -> void:
	speed = 300
	range = 200
	damage = 0.1
	piercing = true
	modulate = Color(1,randf_range(.7,1), randf_range(.7,1))
