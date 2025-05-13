extends Control

signal level_selected(level_info: LevelInfo)
signal back_pressed

@onready var level_list: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/LevelList
@onready var start_run_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/StartRunButton


var selected_level_info: LevelInfo

@export var levels_infos: Array[LevelInfo]

func _ready():
	# Populate list
	for level_info in levels_infos:
		var button = preload("res://menu/level_select/level_button.tscn").instantiate()
		button.setup(level_info)
		button.pressed.connect(_on_level_selected.bind(level_info))
		level_list.add_child(button)

	start_run_button.disabled = true
	start_run_button.pressed.connect(_on_start_run)

func _on_level_selected(level_info: LevelInfo):
	selected_level_info = level_info
	start_run_button.disabled = false

func _on_start_run():
	if selected_level_info:
		level_selected.emit(selected_level_info.duplicate(true))


func _on_back_button_pressed() -> void:
	back_pressed.emit()
