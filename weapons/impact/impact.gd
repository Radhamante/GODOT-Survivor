extends GPUParticles2D
class_name  ImpactParticules


func _ready() -> void:
	connect('finished', _on_finished)
	emitting = true

func _on_finished() -> void:
	queue_free()
