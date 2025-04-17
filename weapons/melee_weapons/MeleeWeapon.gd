# melee_weapon.gd
extends Area2D
class_name MeleeWeapon

@export var hit_effects: Array[EffectComponent] = []
@export var on_entered_damageSource: DamageSource
@export var overtime_damageSource: DamageSource
@export var overtime_delay: float = .2
@export var movement_behavior: WeaponMovementBehavior

@onready var _overtime_timer = overtime_delay


func _process(delta: float) -> void:
	if overtime_damageSource:
		_overtime_timer -= delta
		if _overtime_timer <= 0:
			_overtime_timer = overtime_delay
			overtime_damageSource.source_position = Variables.Player.global_position
			for body in get_overlapping_bodies():
				if body is Monster:
					body.take_damage(overtime_damageSource)
					for effect in hit_effects:
						effect.apply(self, body)

func _physics_process(delta: float) -> void:
	if movement_behavior:
		movement_behavior.update_movement(self, delta)

func _on_body_entered(body: Node2D) -> void:
	if body is Monster and on_entered_damageSource:
		on_entered_damageSource.source_position = Variables.Player.global_position
		body.take_damage(on_entered_damageSource)
		for effect in hit_effects:
			effect.apply(self, body)
