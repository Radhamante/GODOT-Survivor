extends CharacterBody2D
class_name Monster

var modifiers: Array[MonsterModifier]

@export var base_stats: MonsterStats
var stats: MonsterStats

@onready var player: CharacterBody2D = get_node("/root/Game/Player")
@onready var animation: AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	animation.queue("Move")
	stats = base_stats.duplicate()
	for modifier in modifiers:
		modifier.apply(self)

func _physics_process(delta: float) -> void:
	move(delta)
	var collision = move_and_slide()
	if collision:
		for i in range(get_slide_collision_count()):
			var col = get_slide_collision(i)
			if col.get_collider() == player:
				velocity = Vector2.ZERO
	
func move(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	var distance = global_position.distance_to(player.global_position)
	
	if distance > 3:
		velocity = direction * stats.speed
	else:
		velocity = Vector2.ZERO
	look_at_player()
		
func look_at_player():
	if player.global_position.x < global_position.x:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true

func _show_crit_particles(bullet: Bullet) -> void:
	const CRIT_PARTICLES = preload("res://pistols/impact/critical_hit.tscn")
	var particles = CRIT_PARTICLES.instantiate()
	particles.global_position = global_position
	particles.global_rotation = bullet.global_rotation
	get_parent().add_child(particles)
	
func _calculate_damages(bullet: Bullet) -> float:
	var damage = bullet.damageSource.damage
	
	# ARMOR
	if bullet.damageSource.types.has(Enums.DamageType.PHYSICAL):
		damage -= max(stats.armor - bullet.damageSource.armor_penetration, 0)

	# RESISTANCES
	var resistance_multiplier := 1.0
	for damage_type in bullet.damageSource.types:
		if stats.resistance.has(damage_type):
			var resistance = stats.resistance[damage_type]
			resistance_multiplier *= resistance
	damage = damage * resistance_multiplier
	
	# CRIT
	var is_critical = randf() < bullet.damageSource.crit_chance
	if is_critical:
		var crit_damage = bullet.damageSource.damage - bullet.damageSource.damage * bullet.damageSource.crit_damage
		if stats.resistance.has(Enums.DamageType.CRITICAL):
			crit_damage *= stats.resistance[Enums.DamageType.CRITICAL]
		damage += bullet.damageSource.crit_damage
		_show_crit_particles(bullet)
	
	return damage

func _kill():
	queue_free()
	const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke = SMOKE_EXPLOSION.instantiate()
	smoke.global_position = global_position
	get_parent().add_child(smoke)

func take_damage(bullet: Bullet):
	var damage = _calculate_damages(bullet)
	if damage > 0:
		stats.health -= damage
		animation.play("hurt")
	else: 
		animation.play("immune")
		animation.queue("RESET")
	animation.queue("Move")
	if stats.health <= 0:
		_kill()
	
