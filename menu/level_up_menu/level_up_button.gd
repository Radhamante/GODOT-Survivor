extends Button

var weapon: Variant
var upgrade: WeaponUpgradeNode

signal upgrade_selected(_weapon: Variant, _upgrade: WeaponUpgradeNode)

@onready var upgrade_list: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/UpgradeList
@onready var weapon_name: Label = $MarginContainer/VBoxContainer/WeaponName


func setup(_weapon: Variant, _upgrade: WeaponUpgradeNode):
	weapon = _weapon
	upgrade = _upgrade
	
	await ready
	
	weapon_name.text = weapon.weapon_name
	
	for modifier: Modifier in _upgrade.modifiers:
		var upgrade_value = Label.new()
		var upgrade_logo = TextureRect.new()
		upgrade_logo.texture = modifier.display_logo
		upgrade_logo.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		upgrade_logo.custom_minimum_size = Vector2(100,100)
		
		upgrade_value.text = modifier.display_value
		
		upgrade_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		
		upgrade_list.add_child(upgrade_logo)
		upgrade_list.add_child(upgrade_value)
	


func _on_pressed() -> void:
	upgrade_selected.emit(weapon,upgrade)
