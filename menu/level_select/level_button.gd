extends Button

var level_name: String
var level_description: String
var level_icon: Texture2D

@onready var name_label = $HBoxContainer/VBox/Name
@onready var desc_label = $HBoxContainer/VBox/Description
@onready var icon_rect = $HBoxContainer/MarginContainer/Icon

func setup(name: String, desc: String, icon: Texture2D):
	await ready
	level_name = name
	level_description = desc
	level_icon = icon

	name_label.text = level_name
	desc_label.text = level_description
	icon_rect.texture = level_icon
	
	var content_height = $HBoxContainer.get_combined_minimum_size().y + 60
	var content_width = $HBoxContainer.get_combined_minimum_size().x + 60
	custom_minimum_size = Vector2(content_width, content_height)
