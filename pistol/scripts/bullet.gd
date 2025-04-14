extends Area2D
class_name Bullet

var travelled_distance = 0

var speed: float = 1000.0
var range: float = 1200.0
var damage: float = 1.0
var piercing: bool = false
var armor_penetration: float = 0.0
var crit_chance: float = 0
var crit_damage: float = 1.5
var types: Array[Enums.DamageType]

var process: Array[Callable]
var on_hit: Array[Callable]

func apply_modifier(modifier: BulletModifier):
	modifier.apply(self)

func get_piercing_damage_reduction() -> float:
	return 0.0

func _physics_process(delta: float) -> void:
	for p in process:
		p.call(self, delta)
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	travelled_distance += speed * delta
	if travelled_distance > range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Monster:
		body.take_damage(self)
	if not piercing:
		queue_free()
	else:
		damage -= get_piercing_damage_reduction()
	if damage <= 0:
		queue_free()
