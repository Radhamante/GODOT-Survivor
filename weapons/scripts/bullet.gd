extends Area2D
class_name Bullet

var travelled_distance = 0

@export var base_damageSource: DamageSource
@onready var damageSource = base_damageSource.duplicate()

@export var base_bulletStats: BulletStats
@onready var bulletStats := base_bulletStats.duplicate()

var hit_effects: Array[EffectComponent] = []

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
	if body is Monster:
		body.take_damage(self.damageSource)
		for effect in hit_effects:
			effect.apply(body)
	if not bulletStats.piercing:
		queue_free()
	else:
		damageSource.damage -= get_piercing_damage_reduction()
	if damageSource.damage < 0.1:
		queue_free()
