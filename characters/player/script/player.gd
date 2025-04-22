extends CharacterBody2D

signal heath_depleted

@export var character_info: CharacterInfo

func _ready() -> void:
	Variables.Player = self
	
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
		%ProgressBar.value = character_info.health
		if character_info.health <= 0:
			heath_depleted.emit()
