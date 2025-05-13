extends Node2D

@onready var player: Player = $Player
@onready var difficulty_manager: DifficultyManager = %DifficultyManager
@onready var background_music: AudioStreamPlayer = $BackgroundMusic
@onready var background_texture: TextureRect = $Background/BackgroundTexture

func setup(level_info: LevelInfo, character_info: CharacterInfo):
	await ready
	player.setup(character_info)
	
	background_texture.texture = level_info.background
	difficulty_manager.difficulty_levels = level_info.difficulty_levels
	background_music.stream = level_info.music
	background_music.playing = true
	
	return player

func _on_player_heath_depleted() -> void:
	game_over()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
		MenuRoot.show_menu(MenuRoot.menus_enum.PAUSE)

func game_over():
	get_tree().paused = true
	MenuRoot.show_menu((MenuRoot.menus_enum.GAMEOVER))


func _on_difficulty_manager_difficulty_changed(difficulty_level: DifficultyLevel) -> void:
	$MobGenerator.update_difficulty_level(difficulty_level)
