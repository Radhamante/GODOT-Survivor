extends Magnetable
class_name XPMagnetable

var value: float
	
func _physics_process(delta: float) -> void:
	if not entity:
		return
	var direction = (entity.global_position - global_position).normalized()
	global_position += direction * speed * delta
