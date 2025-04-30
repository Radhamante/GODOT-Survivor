extends CharacterBody2D
class_name Player

signal heath_depleted
signal xp_level(xp: float, level: int, xp_for_next_level:float)
signal health_updated(current_heath: float, max_health: float)

@export var character_info: CharacterInfo

var weapons: Array[Weapon]:
	get = _get_weapon

func _get_weapon() -> Array[Weapon]:
	var weapons:Array[Weapon] = []
	for weapon_child in $Weapons.get_children():
		weapons.push_back(weapon_child as Weapon)
	return weapons

func _ready() -> void:
	Variables.player = self
	
	if character_info.appearance is PackedScene:
		add_child(character_info.appearance.instantiate())
	else:
		push_error("CharacterInfo '%s' has invalid appearance. Expected a PackedScene!" % character_info.character_name)
	
	for weapon in character_info.weapons:
		if weapon is PackedScene:
			$Weapons.add_weapon(weapon)
		else:
			push_error("CharacterInfo '%s' has an weapon. " % character_info.character_name)
			printerr("Invalide Weapon", weapon)
	
	%ProgressBar.max_value = character_info.max_health
	%ProgressBar.value = character_info.health
	
	health_updated.emit(character_info.health, character_info.max_health)
	xp_level.emit(character_info.xp, character_info.level, character_info.xp_by_level_multipler)

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * 600
	
	move_and_slide()
	
	if(velocity.length() > 0):
		$Anim.play_walk()
	else: 
		$Anim.play_idle()

	var overlapping_mobs: Array[Node2D] = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		var overlapping_damages = overlapping_mobs.reduce(func (sum, next): return sum + next.stats.damage, 0)
		character_info.health -= overlapping_damages * delta
		health_updated.emit(character_info.health, character_info.max_health)
		%ProgressBar.value = character_info.health
		if character_info.health <= 0:
			heath_depleted.emit()

func _level_up():
	$LevelUpParticules.emitting = true
	character_info.xp -= character_info.level * character_info.xp_by_level_multipler
	character_info.level += 1
	
	var upgrade_list = []
	for weapon in $Weapons.get_children():
		for upgrade in weapon.next_upgrades:
			upgrade_list.push_back([weapon, upgrade])
			
	if upgrade_list.is_empty():
		return
		
	var selected_upgrades = []
	for i in range(character_info.upgrade_by_level):
		var random_index =  randi() % upgrade_list.size() if upgrade_list.size() > 0 else -1
		if random_index >= 0:
			selected_upgrades.push_back(upgrade_list[random_index])
			upgrade_list.remove_at(random_index)

	MenuRoot.show_level_up_menu(selected_upgrades)
	
func level_up_upgrade_selected(_weapon: Variant, _upgrade: WeaponUpgradeNode):
	for mod in _upgrade.modifiers:
		_weapon.add_modifier(mod)
	var index = _weapon.next_upgrades.find(_upgrade)
	_weapon.next_upgrades.remove_at(index)
	_weapon.next_upgrades += _upgrade.nexts
	

func _on_magnet_area_entered(magnetable: Magnetable) -> void:
	magnetable.magnet_to(self)
	

func _on_pickup_area_entered(magnetable: Magnetable) -> void:
	if magnetable is XPMagnetable:
		character_info.xp += magnetable.value
		var xp_for_next_level = character_info.level * character_info.xp_by_level_multipler
		if character_info.xp >= xp_for_next_level:
			_level_up()
		xp_level.emit(character_info.xp, character_info.level, xp_for_next_level)
	magnetable.queue_free()
