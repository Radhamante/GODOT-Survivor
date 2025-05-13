extends Control
class_name GameOverMenu

signal main_menu_pressed

func _on_button_pressed() -> void:
	main_menu_pressed.emit()
