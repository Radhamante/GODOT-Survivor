extends Bullet

var time_to_zero = 1.0
var opacity = 1.0


func _physics_process(delta: float) -> void:
	if bulletStats.speed > 0.0:
		var deceleration = bulletStats.speed / time_to_zero
		bulletStats.speed -= deceleration * delta
	super._physics_process(delta)

func _ready() -> void:
	modulate = Color(1,randf_range(.7,1), randf_range(.7,1))
