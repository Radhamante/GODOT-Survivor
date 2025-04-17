extends Button

var my_icon: Texture2D
var label_text: String

@onready var icon_node = $VBoxContainer/Icon
@onready var label_node = $VBoxContainer/Label

func setup(_icon: Texture2D, _text: String):
	await ready
	my_icon = _icon
	label_text = _text
	icon_node.texture = my_icon
	label_node.text = label_text
	
	
	var content_height = $VBoxContainer.get_combined_minimum_size().y + 60
	custom_minimum_size = Vector2(content_height, content_height)
