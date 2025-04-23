extends ProgressBar

func _on_player_xp_level(xp: int, level: int, xp_for_next_level: int) -> void:
	max_value = xp_for_next_level
	value = xp
