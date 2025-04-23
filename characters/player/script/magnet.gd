extends Area2D

func _on_area_entered(magnetable: Magnetable) -> void:
	magnetable.entity = get_parent()
