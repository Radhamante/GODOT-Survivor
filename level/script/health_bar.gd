extends ProgressBar


func _on_player_health_updated(current_heath: float, max_health: float) -> void:
	max_value = max_health
	value = current_heath
