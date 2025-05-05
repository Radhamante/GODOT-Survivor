extends Control

@onready var weapon_name: Label = $NinePatchRect/MarginContainer/VBoxContainer/WeaponName
@onready var v_box_container: VBoxContainer = $NinePatchRect/MarginContainer/VBoxContainer
@onready var nine_patch_rect: NinePatchRect = $NinePatchRect

func setup(weapon: Weapon):
	await ready
	weapon_name.text = weapon.weapon_name
	for modifier: Modifier in weapon.weapon_modifiers:
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
	if nine_patch_rect.get_child_count() > 0 and nine_patch_rect.get_child(0) is Container:
		var container = nine_patch_rect.get_child(0)
		var content_size = container.get_combined_minimum_size()
		
		nine_patch_rect.custom_minimum_size = content_size
		nine_patch_rect.size = nine_patch_rect.custom_minimum_size
