extends Node2D


func _on_player_heath_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
		MenuRoot.show_menu(MenuRoot.menus_enum.PAUSE)
		MenuRoot.show()

func game_over():
	get_tree().paused = true
	MenuRoot.show_menu(MenuRoot.show_menu(MenuRoot.menus_enum.GAMEOVER))
	MenuRoot.show()


func _on_difficulty_manager_difficulty_changed(difficulty_level: DifficultyLevel) -> void:
	$MobGenerator.update_difficulty_level(difficulty_level)
