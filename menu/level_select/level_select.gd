extends Control

signal level_selected(level_info: LevelInfo)

@onready var level_list = $VBoxContainer/ScrollContainer/LevelList
@onready var start_button = $VBoxContainer/StartRunButton

var selected_level_info: LevelInfo

@export var levels_infos: Array[LevelInfo]

func _ready():
	# Populate list
	for level_info in levels_infos:
		var button = preload("res://menu/level_select/level_button.tscn").instantiate()
		button.setup(level_info)
		button.pressed.connect(_on_level_selected.bind(level_info))
		level_list.add_child(button)

	start_button.disabled = true
	start_button.pressed.connect(_on_start_run)

func _on_level_selected(level_info: LevelInfo):
	selected_level_info = level_info
	start_button.disabled = false

func _on_start_run():
	if selected_level_info:
		level_selected.emit(selected_level_info.duplicate(true))
