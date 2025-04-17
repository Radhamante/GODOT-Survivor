extends Control

signal start_run()

@onready var level_list = $VBoxContainer/ScrollContainer/LevelList
@onready var start_button = $VBoxContainer/StartRunButton

var selected_level_data = null

var levels = [
	{
		"name": "Forêt Maudite",
		"description": "Un lieu sombre et dangereux, peuplé de créatures maudites.",
		"icon": preload("res://menu/sprite/forest.webp")
	},
	{
		"name": "Ruines Anciennes",
		"description": "Des ruines mystérieuses pleines de pièges.",
		"icon": preload("res://menu/sprite/ruins.webp")
	}
]

func _ready():
	# Populate list
	for level in levels:
		var button = preload("res://menu/level_select/level_button.tscn").instantiate()
		button.setup(level.name, level.description, level.icon)
		button.pressed.connect(_on_level_selected.bind(level))
		level_list.add_child(button)

	start_button.disabled = true
	start_button.pressed.connect(_on_start_run)

func _on_level_selected(level):
	selected_level_data = level
	start_button.disabled = false

func _on_start_run():
	if selected_level_data:
		start_run.emit()
