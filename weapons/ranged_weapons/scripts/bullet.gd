extends Area2D
class_name Bullet

signal before_monster_hited(bullet: Bullet, monster: Monster)
signal after_monster_hited(bullet: Bullet, monster: Monster)
var travelled_distance = 0

@export var damage_source: DamageSource
@export var bulletStats: BulletStats

@export var modifiers: Array[Modifier] = []
@export var hit_effects: Array[EffectComponent] = []


func _ready() -> void:
	damage_source.source_position = global_position

func setup(
	_modifiers: Array[Modifier] = [], 
	_hit_effects: Array[EffectComponent] = []
) -> void:
	await ready
	modifiers += _modifiers
	hit_effects += _hit_effects
	_apply_modifier()

func _apply_modifier():
	for mod in modifiers:
		if mod.operation == "add":
			mod.apply(self)
	for mod in modifiers:
		if mod.operation == "mult":
			mod.apply(self)
	for mod in modifiers:
		if mod.operation == "set":
			mod.apply(self)

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * bulletStats.speed * delta
	
	travelled_distance += bulletStats.speed * delta
	if travelled_distance > bulletStats.range:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is not Monster:
		return
	before_monster_hited.emit(self, body)
	body.take_damage(damage_source)
	for effect in hit_effects:
		effect.apply(self, body)
	if not bulletStats.piercing:
		queue_free()
	else:
		damage_source.damage *= 1 - damage_source.damage_reduction_on_piercing
	if damage_source.damage < 0.1:
		queue_free()
	after_monster_hited.emit(self, body)
