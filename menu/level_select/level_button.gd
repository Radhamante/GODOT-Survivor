extends Button

var level_name: String
var level_description: String
var level_icon: Texture2D

@onready var name_label = $HBoxContainer/VBox/Name
@onready var desc_label = $HBoxContainer/VBox/Description
@onready var difficulty = $HBoxContainer/VBox/Difficulty
@onready var icon_rect = $HBoxContainer/MarginContainer/Icon

func setup(level_info: LevelInfo):
	await ready
	level_name = level_info.name
	level_description = level_info.description
	level_icon = level_info.logo
	
	for i in range(1, 6):
		var star_container = Control.new()
		star_container.custom_minimum_size = Vector2(20, 20)
		star_container.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		star_container.size_flags_vertical = Control.SIZE_SHRINK_CENTER

		var star = TextureRect.new()
		star.expand = true
		star.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		star.anchor_right = 1
		star.anchor_bottom = 1

		if i <= level_info.dificulty:
			star.texture = preload("res://menu/sprite/star.png")
		else:
			star.texture = preload("res://menu/sprite/star_outline.png")

		star_container.add_child(star)
		difficulty.add_child(star_container)

		
	button_group = preload("res://menu/level_select/level_button_group.tres")
	add_theme_stylebox_override("pressed", get_theme_stylebox("toggle"))

	name_label.text = level_name
	desc_label.text = level_description
	icon_rect.texture = level_icon
	
	var content_height = $HBoxContainer.get_combined_minimum_size().y + 60
	var content_width = $HBoxContainer.get_combined_minimum_size().x + 60
	custom_minimum_size = Vector2(content_width, content_height)
