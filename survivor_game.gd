extends Node2D

func _on_player_heath_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
