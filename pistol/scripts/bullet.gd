extends Area2D
class_name Bullet

var travelled_distance = 0

var speed: float = 1000.0
var range: float = 1200.0
var damage: float = 1.0
var piercing: bool = false

func get_piercing_damage_reduction() -> float:
	return 0.0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	travelled_distance += speed * delta
	if travelled_distance > range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Monster:
		body.take_damage(damage)
	if not piercing:
		queue_free()
	else:
		damage -= get_piercing_damage_reduction()
	if damage <= 0:
		queue_free()
