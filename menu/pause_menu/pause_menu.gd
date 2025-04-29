extends Control
class_name PauseMenu

signal resume_pressed

func _on_resume_pressed() -> void:
	resume_pressed.emit()
