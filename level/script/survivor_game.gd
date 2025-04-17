extends Node2D


func _on_player_heath_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
		$"../MenuRoot".show_menu("pause")
		$"../MenuRoot".show()

func game_over():
	get_tree().paused = true
	$"../MenuRoot".show_menu("gameover")
	$"../MenuRoot".show()
