extends ProgressBar

func _on_player_xp_level(xp: float, level: int, xp_for_next_level: float) -> void:
	max_value = xp_for_next_level
	value = xp
