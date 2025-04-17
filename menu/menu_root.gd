extends Control

var current_menu = "main"
var menus

func _ready():
	menus = {
		"main": $MainMenu,
		"character": $CharacterSelect,
		"level": $LevelSelect,
		"options": $OptionsMenu,
		"pause": $PauseMenu,
		"gameover": $GameOverMenu
	}
	show_menu("main")
	
	$MainMenu.start_pressed.connect(_on_ButtonStart_pressed)
	$MainMenu.options_pressed.connect(_on_ButtonOptions_pressed)
	$MainMenu.quit_pressed.connect(_on_ButtonQuit_pressed)
	
	$CharacterSelect.continue_pressed.connect(_on_CharacterChosen)
	$CharacterSelect.back_pressed.connect(_on_ButtonBack_pressed)
	
	$LevelSelect.start_run.connect(_on_LevelChosen)

func show_menu(name: String):
	for key in menus:
		menus[key].visible = (key == name)
	current_menu = name

func _on_ButtonStart_pressed():
	show_menu("character")

func _on_ButtonBack_pressed():
	if current_menu in ["character", "level", "options"]:
		show_menu("main")

func _on_CharacterChosen():
	show_menu("level")

func _on_LevelChosen():
	start_game()

func _on_ButtonOptions_pressed():
	show_menu("options")

func _on_ButtonQuit_pressed():
	get_tree().quit()

func start_game():
	var scene = preload("res://level/scene/survivor_game.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()
