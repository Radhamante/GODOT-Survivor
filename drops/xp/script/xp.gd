extends Magnetable
class_name XPMagnetable

var value: float
var merged := false

func _modulate_on_value() -> void:
	var h = 190.0 / 360.0
	var s = clamp(0.2 + (value * 0.1), 0.0, 1.0)
	var v = 1.0 
	modulate = Color.from_hsv(h, s, v)
	
	scale = Vector2.ONE * (1.0 + clamp((value * 0.05), .0, .5))

func _ready() -> void:
	_modulate_on_value()
	
func _physics_process(delta: float) -> void:
	if not entity:
		return
	var direction = (entity.global_position - global_position).normalized()
	global_position += direction * speed * delta


func _on_area_entered(area: Area2D) -> void:
	if merged or not is_instance_valid(area):
		return

	if area is XPMagnetable:
		var other: XPMagnetable = area

		# Évite le double merge
		if self.get_instance_id() < other.get_instance_id():
			# On garde celui avec l'ID le plus bas
			value += other.value
			other.merged = true
			other.queue_free()
			_modulate_on_value()
	print("megred with : ", value)
