extends Control

signal back_pressed
signal character_selected(character_name)
signal continue_pressed(character_info: CharacterInfo)

@onready var character_list = $MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/CharacterList
@onready var details_panel = $MarginContainer/HBoxContainer/DetailsPanel
@onready var character_name_label = details_panel.get_node("CharacterName")
@onready var character_description_label = details_panel.get_node("ScrollContainer/CharacterDescription")
@onready var continue_button: Button = $MarginContainer/HBoxContainer/DetailsPanel/MarginContainer/ContinueButton

@export var characters_infos : Array[CharacterInfo]

var selected_character = null

func _ready() -> void:
	# Clear & populate list
	for child in character_list.get_children():
		child.queue_free()
	for character_info in characters_infos:
		var btn = preload("res://menu/character_select/character_button.tscn").instantiate()
		btn.setup(character_info)
		character_list.add_child(btn)
		btn.pressed.connect(_on_character_pressed.bind(character_info.duplicate()))

	continue_button.disabled = true

func _on_character_pressed(character_info: CharacterInfo):
	selected_character = character_info
	details_panel.visible = true
	character_name_label.text = character_info.character_name
	character_description_label.text = character_info.description
	continue_button.disabled = false
	character_selected.emit(character_info.character_name)

func _on_back_pressed():
	back_pressed.emit()

func _on_continue_pressed():
	if selected_character:
		continue_pressed.emit(selected_character.duplicate(true))
