extends Button

var weapon: Variant
var upgrade: WeaponUpgradeNode

signal upgrade_selected(_weapon: Variant, _upgrade: WeaponUpgradeNode)

func setup(_weapon: Variant, _upgrade: WeaponUpgradeNode):
	weapon = _weapon
	upgrade = _upgrade



func _on_pressed() -> void:
	upgrade_selected.emit(weapon,upgrade)
