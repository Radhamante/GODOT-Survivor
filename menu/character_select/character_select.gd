extends Control

signal back_pressed
signal character_selected(character_name)
signal continue_pressed()

@onready var character_list = $MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/CharacterList
@onready var details_panel = $MarginContainer/HBoxContainer/DetailsPanel
@onready var character_name_label = details_panel.get_node("CharacterName")
@onready var character_description_label = details_panel.get_node("ScrollContainer/CharacterDescription")
@onready var continue_button = details_panel.get_node("ContinueButton")

var characters = [
	{ "name": "JAUNE", "icon": preload("res://characters/player/sprites/alienYellow.png"), "description": "Un alien rapide." },
	{ "name": "BLEU", "icon": preload("res://characters/player/sprites/alienYellow.png"), "description": "Un alien tanky." },
]

var selected_character = null

func _ready() -> void:
	# Clear & populate list
	clear_character_list()
	for char_data in characters:
		var btn = preload("res://menu/character_select/character_button.tscn").instantiate()
		btn.setup(char_data.icon, char_data.name)
		character_list.add_child(btn)
		btn.pressed.connect(_on_character_pressed.bind(char_data))
		character_list.add_child(btn)

	# Hide right panel at first
	details_panel.visible = false
	continue_button.visible = false

func _on_character_pressed(char_data):
	selected_character = char_data
	details_panel.visible = true
	character_name_label.text = char_data.name
	character_description_label.text = char_data.description
	continue_button.visible = true
	character_selected.emit(char_data.name)

func _on_back_pressed():
	back_pressed.emit()

func _on_continue_pressed():
	if selected_character:
		continue_pressed.emit()

func clear_character_list():
	for child in character_list.get_children():
		child.queue_free()
