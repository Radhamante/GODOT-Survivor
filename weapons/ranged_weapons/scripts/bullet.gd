extends Area2D
class_name Bullet

signal before_monster_hited(bullet: Bullet, monster: Monster)
signal after_monster_hited(bullet: Bullet, monster: Monster)
var travelled_distance = 0

@export var damageSource: DamageSource
@export var bulletStats: BulletStats

var hit_effects: Array[EffectComponent] = []

func _ready() -> void:
	damageSource.source_position = global_position

func apply_modifier(modifier: BulletModifier):
	modifier.apply(self)

func get_piercing_damage_reduction() -> float:
	return 0.0

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
	body.take_damage(damageSource)
	for effect in hit_effects:
		effect.apply(self, body)
	if not bulletStats.piercing:
		queue_free()
	else:
		damageSource.damage *= 1 - damageSource.damage_reduction_on_piercing
	if damageSource.damage < 0.1:
		queue_free()
	after_monster_hited.emit(self, body)
