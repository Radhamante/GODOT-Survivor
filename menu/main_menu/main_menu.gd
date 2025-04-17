extends Control

signal start_pressed
signal options_pressed
signal quit_pressed


func _on_button_start_pressed() -> void:
	start_pressed.emit()


func _on_button_options_pressed() -> void:
	options_pressed.emit()


func _on_button_quit_pressed() -> void:
	quit_pressed.emit()
