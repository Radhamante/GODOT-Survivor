extends Control

var selected_weapon: Array

signal weapon_selected(_weapon: Weapon)
@onready var buttons_container: HBoxContainer = $MarginContainer/HBoxContainer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func setup(weapons: Array):
	for child in buttons_container.get_children():
		child.queue_free()
	for weapon in weapons:
		const WEAPON_SELECT_BUTTON = preload("res://menu/weapoon_select_menu/weapon_select_button.tscn")
		var button = WEAPON_SELECT_BUTTON.instantiate()
		button.setup(weapon)
		button.connect("weapon_selected", _on_weapon_selected)
		buttons_container.add_child(button)
	audio_stream_player.play()

func _on_weapon_selected(_weapon: Weapon):
	weapon_selected.emit(_weapon)
