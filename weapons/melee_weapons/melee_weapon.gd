extends Area2D
class_name MeleeWeapon

@export var weapon_modifiers:Array[MeleeWeaponModifier] = []
@export var hit_effects: Array[EffectComponent] = []
@export var base_damage_source: DamageSource
@export var base_movement_behavior: WeaponMovementBehavior

var damage_source: DamageSource
var movement_behavior: WeaponMovementBehavior

var overtime_delay: float = .2
@onready var _overtime_timer = overtime_delay

func _ready() -> void:
	_apply_weapon_modifiers()

func _apply_weapon_modifiers():
	damage_source = base_damage_source.duplicate(true)
	movement_behavior = base_movement_behavior.duplicate(true)
	for mod in weapon_modifiers:
		if mod.operation == "add":
			mod.apply(self)
	for mod in weapon_modifiers:
		if mod.operation == "multiply":
			mod.apply(self)
	for mod in weapon_modifiers:
		if mod.operation == "set":
			mod.apply(self)

func add_modifier(modifier: MeleeWeaponModifier):
	weapon_modifiers.push_back(modifier)
	_apply_weapon_modifiers()


func _process(delta: float) -> void:
	_overtime_timer -= delta
	if _overtime_timer <= 0:
		_overtime_timer = overtime_delay
		damage_source.source_position = Variables.Player.global_position
		for body in get_overlapping_bodies():
			if body is Monster:
				body.take_damage(damage_source)
				for effect in hit_effects:
					effect.apply(self, body)

func _physics_process(delta: float) -> void:
	if movement_behavior:
		movement_behavior.update_movement(self, delta)

func _on_body_entered(body: Node2D) -> void:
	if body is Monster:
		damage_source.source_position = Variables.Player.global_position
		body.take_damage(damage_source)
		for effect in hit_effects:
			effect.apply(self, body)
