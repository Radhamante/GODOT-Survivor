extends Control
class_name PauseMenu

signal resume_pressed
signal main_menu_pressed

@onready var weapons_list: HBoxContainer = $VBoxContainer/WeaponsList
var pause_open = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and pause_open:
		_on_resume_pressed()

func _on_resume_pressed() -> void:
	resume_pressed.emit()


func _on_main_menu_pressed() -> void:
	main_menu_pressed.emit()

const PAUSE_WEAPON = preload("res://menu/pause_menu/pause_weapon.tscn")

func _on_draw() -> void:
	pause_open = true
	for child in weapons_list.get_children():
		child.queue_free()
	for weapon in Variables.player.weapons:
		var weapon_scene = PAUSE_WEAPON.instantiate()
		weapon_scene.setup(weapon)
		
		weapons_list.add_child(weapon_scene)


func _on_hidden() -> void:
	pause_open = false


func _on_options_pressed() -> void:
	MenuRoot.show_menu(MenuRoot.menus_enum.OPTIONS)
