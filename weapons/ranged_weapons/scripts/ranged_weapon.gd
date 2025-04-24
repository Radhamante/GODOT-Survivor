extends Area2D
class_name RandedWeapon

@export var weapon_modifiers:Array[WeaponModifier] = []
@export var bullet_modifiers: Array[BulletModifier] = []
@export var hit_effects: Array[EffectComponent] = []
@export var shoot_behavior: ShootBehavior
@export var movement_behavior: WeaponMovementBehavior


# Function to apply modifiers to a given value
func apply_weapon_modifiers():
	for mod in weapon_modifiers:
		if mod.operation == "add":
			mod.apply(self)
	for mod in weapon_modifiers:
		if mod.operation == "mult":
			mod.apply(self)
	for mod in weapon_modifiers:
		if mod.operation == "set":
			mod.apply(self)
	
func apply_bullet_modifier(bullet: Bullet):
	for mod in bullet_modifiers:
		if mod.operation == "add":
			mod.apply(bullet)
	for mod in bullet_modifiers:
		if mod.operation == "mult":
			mod.apply(bullet)
	for mod in bullet_modifiers:
		if mod.operation == "set":
			mod.apply(bullet)

func _process(delta: float) -> void:
	if shoot_behavior:
		shoot_behavior.shoot(self, delta)


func _physics_process(delta: float) -> void:
	if movement_behavior:
		movement_behavior.update_movement(self, delta)
