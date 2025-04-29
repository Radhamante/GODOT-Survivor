extends CanvasLayer

var current_menu = "main"
var menus

var selected_character_info: CharacterInfo
var selected_level_info: LevelInfo

@onready var main_menu = $MainMenu
@onready var character_select_menu = $CharacterSelectMenu
@onready var level_select_menu = $LevelSelectMenu
@onready var options_menu = $OptionsMenu
@onready var pause_menu = $PauseMenu
@onready var game_over_menu = $GameOverMenu
@onready var level_up_menu = $LevelUpMenu

enum menus_enum {
	MAIN,
	CHARACTER,
	LEVEL,
	OPTIONS,
	PAUSE,
	GAMEOVER,
	LEVELUP,
}

func _ready():
	menus = {
		menus_enum.MAIN: main_menu,
		menus_enum.CHARACTER: character_select_menu,
		menus_enum.LEVEL: level_select_menu,
		menus_enum.OPTIONS: options_menu,
		menus_enum.PAUSE: pause_menu,
		menus_enum.GAMEOVER: game_over_menu,
		menus_enum.LEVELUP: level_up_menu,
	}
	show_menu(menus_enum.MAIN)
		
	main_menu.start_pressed.connect(_on_ButtonStart_pressed)
	main_menu.options_pressed.connect(_on_ButtonOptions_pressed)
	main_menu.quit_pressed.connect(_on_ButtonQuit_pressed)
	
	character_select_menu.continue_pressed.connect(_on_CharacterChosen)
	character_select_menu.back_pressed.connect(_on_ButtonBack_pressed)
	
	level_select_menu.level_selected.connect(_on_LevelChosen)
		

func hide_all_menu():
	for key in menus:
		menus[key].visible = false

func show_menu(name: menus_enum):
	for key in menus:
		menus[key].visible = (key == name)
	current_menu = name
	
func show_level_up_menu(_selected_upgrades: Array):
	level_up_menu.setup(_selected_upgrades)
	show_menu(menus_enum.LEVELUP)
	get_tree().paused = true
	

func _on_ButtonStart_pressed():
	show_menu(menus_enum.CHARACTER)

func _on_ButtonBack_pressed():
	if current_menu in [menus_enum.CHARACTER, menus_enum.LEVEL, menus_enum.OPTIONS]:
		show_menu(menus_enum.MAIN)

func _on_CharacterChosen(_selected_character_info: CharacterInfo):
	selected_character_info = _selected_character_info
	show_menu(menus_enum.LEVEL)

func _on_LevelChosen(_selected_level_info: LevelInfo):
	selected_level_info = _selected_level_info
	start_game()

func _on_ButtonOptions_pressed():
	show_menu(menus_enum.OPTIONS)

func _on_ButtonQuit_pressed():
	get_tree().quit()

func start_game():
	var scene = preload("res://level/scene/survivor_game.tscn").instantiate()
	scene.get_node("Player").character_info = selected_character_info
	scene.get_node("DifficultyManager").difficulty_levels = selected_level_info.difficulty_levels
	get_tree().root.add_child(scene)
	hide_all_menu()


func _on_pause_menu_resume_pressed() -> void:
	get_tree().paused = false
	hide_all_menu()


func _on_level_up_menu_upgrade_selected(_weapon: Variant, _upgrade: WeaponUpgradeNode) -> void:
	get_tree().paused = false
	hide_all_menu()
