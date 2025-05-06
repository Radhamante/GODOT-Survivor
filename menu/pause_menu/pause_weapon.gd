extends Control

@onready var nine_patch_rect: NinePatchRect = $NinePatchRect
@onready var v_box_container: VBoxContainer = $NinePatchRect/ScrollContainer/MarginContainer/VBoxContainer
@onready var weapon_name: Label = $NinePatchRect/ScrollContainer/MarginContainer/VBoxContainer/WeaponName
@onready var scroll_container: ScrollContainer = $NinePatchRect/ScrollContainer



func setup(weapon: Weapon):
	await ready
	weapon_name.text = weapon.weapon_name
	
	var all_modifiers = weapon.weapon_modifiers + (weapon.bullet_modifiers if "bullet_modifiers" in weapon else [])
	for modifier: Modifier in all_modifiers:
		var modifier_container = HBoxContainer.new()
		
		var logo_wrapper = Control.new()
		logo_wrapper.custom_minimum_size = Vector2(30, 30)
		logo_wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		logo_wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER

		var modifier_logo = TextureRect.new()
		modifier_logo.texture = modifier.display_logo
		modifier_logo.expand_mode = TextureRect.EXPAND_IGNORE_SIZE  # Important : ignore la taille de la texture native
		modifier_logo.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		modifier_logo.anchor_right = 1
		modifier_logo.anchor_bottom = 1
		modifier_logo.offset_right = 0
		modifier_logo.offset_bottom = 0
		modifier_logo.size_flags_horizontal = Control.SIZE_FILL
		modifier_logo.size_flags_vertical = Control.SIZE_FILL

		logo_wrapper.add_child(modifier_logo)

		var modifier_value = Label.new()
		modifier_value.text = modifier.display_value
		modifier_value.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		modifier_container.add_child(logo_wrapper)
		modifier_container.add_child(modifier_value)

		v_box_container.add_child(modifier_container)
		
	_update_ninepatchrect_size()

func _update_ninepatchrect_size():
	if scroll_container.get_child_count() > 0 and scroll_container.get_child(0) is Container:
		var container = scroll_container.get_child(0)
		var content_size:Vector2 = container.get_combined_minimum_size()
		
		content_size.y = min(content_size.y, 400)
		#scroll_container.custom_minimum_size = content_size
		#scroll_container.size = content_size
		scroll_container.set_anchors_preset(PRESET_FULL_RECT)
		#nine_patch_rect.custom_minimum_size = content_size
		nine_patch_rect.size = content_size
		nine_patch_rect.set_anchors_preset(PRESET_TOP_LEFT)
