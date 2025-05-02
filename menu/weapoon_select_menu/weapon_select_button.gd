extends Button

var weapon: Variant

signal weapon_selected(_weapon: Weapon)

@onready var weapon_name: Label = $MarginContainer/VBoxContainer/WeaponName
@onready var weapon_logo: TextureRect = $MarginContainer/VBoxContainer/Control/WeaponLogo


func setup(_weapon: Weapon):
	weapon = _weapon
	
	await ready
	
	weapon_name.text = weapon.weapon_name
	weapon_logo.texture = weapon.logo
	
func _on_pressed() -> void:
	weapon_selected.emit(weapon)
