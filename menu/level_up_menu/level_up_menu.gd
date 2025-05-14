extends Control

var selected_upgrades: Array

signal upgrade_selected(_weapon: Variant, _upgrade: WeaponUpgradeNode)
@onready var buttons_container: HBoxContainer = $MarginContainer/HBoxContainer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func setup(_selected_upgrades: Array):
	for child in buttons_container.get_children():
		child.queue_free()
	for upgrade in _selected_upgrades:
		const LEVEL_UP_BUTTON = preload("res://menu/level_up_menu/level_up_button.tscn")
		var button = LEVEL_UP_BUTTON.instantiate()
		button.setup(upgrade[0], upgrade[1])
		button.connect("upgrade_selected", _on_upgrade_selected)
		buttons_container.add_child(button)
	audio_stream_player.play()

func _on_upgrade_selected(_weapon: Variant, _upgrade: WeaponUpgradeNode):
	upgrade_selected.emit(_weapon, _upgrade)
