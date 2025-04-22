extends Button

var my_icon: Texture2D
var label_text: String

@onready var icon_node = $VBoxContainer/Icon
@onready var label_node = $VBoxContainer/Label

func setup(character_info: CharacterInfo):
	await ready
	my_icon = character_info.logo
	label_text = character_info.character_name
	icon_node.texture = my_icon
	label_node.text = label_text
	
	button_group = preload("res://menu/character_select/character_select_button_group.tres")
	add_theme_stylebox_override("pressed", get_theme_stylebox("toggle"))

	var content_height = $VBoxContainer.get_combined_minimum_size().y + 60
	custom_minimum_size = Vector2(content_height, content_height)
