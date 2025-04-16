extends CharacterBody2D
class_name Monster

var modifiers: Array[MonsterModifier]

@export var move_behavior: MonsterMoveBehavior = FollowMoveBehavior.new()

@export var base_stats: MonsterStats
var stats: MonsterStats

@onready var player: CharacterBody2D = get_node("/root/Game/Player")
@onready var animation: AnimationPlayer = get_node("AnimationPlayer")

var active_dots: Dictionary = {}
var external_velocity: Vector2 = Vector2.ZERO


func _ready() -> void:
	animation.queue("Move")
	stats = base_stats.duplicate()
	for modifier in modifiers:
		modifier.apply(self)

func _physics_process(delta: float) -> void:
	external_velocity = external_velocity.move_toward(Vector2.ZERO, 800 * delta)
	move_behavior.move(self, delta)
	var collision = move_and_slide()
	if collision:
		for i in range(get_slide_collision_count()):
			var col = get_slide_collision(i)
			if col.get_collider() == player:
				velocity = Vector2.ZERO

func look_at_player():
	if player.global_position.x < global_position.x:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true

func _show_crit_particles() -> void:
	const CRITICAL_HIT = preload("res://weapons/impact/critical_hit/critical_hit.tscn")
	var particles = CRITICAL_HIT.instantiate()
	particles.global_position = global_position
	get_parent().add_child(particles)
	
func _calculate_damages( damage_source: DamageSource) -> float:
	var damage = damage_source.damage
	
	# ARMOR
	if damage_source.types.has(Enums.DamageType.PHYSICAL):
		damage -= max(stats.armor - damage_source.armor_penetration, 0)

	# RESISTANCES
	var resistance_multiplier := 1.0
	for damage_type in damage_source.types:
		if stats.resistance.has(damage_type):
			var resistance = stats.resistance[damage_type]
			resistance_multiplier *= resistance
	damage = damage * resistance_multiplier
	
	# CRIT
	var is_critical = randf() < damage_source.crit_chance
	if is_critical:
		var crit_damage = damage_source.damage - damage_source.damage * damage_source.crit_damage
		if stats.resistance.has(Enums.DamageType.CRITICAL):
			crit_damage *= stats.resistance[Enums.DamageType.CRITICAL]
		damage += damage_source.crit_damage
		_show_crit_particles()
	
	return damage

func _kill():
	queue_free()
	const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke = SMOKE_EXPLOSION.instantiate()
	smoke.global_position = global_position
	get_parent().add_child(smoke)

func take_damage(damage_source: DamageSource):
	var damage = _calculate_damages(damage_source)
	if damage > 0:
		stats.health -= damage
		animation.play("hurt")
	else: 
		animation.play("immune")
	animation.queue("RESET")
	animation.queue("Move")
	if stats.health <= 0:
		_kill()
	if damage_source.source_position:
		take_knockback(damage_source.knockback_force, damage_source.source_position)
	if damage_source.particules:
		var particules = damage_source.particules.instantiate()
		if particules is ImpactParticules:
			add_child(damage_source.particules.instantiate())
		else:
			particules.queue_free()

func take_knockback(force: float, source_position: Vector2):
	if force > 0.0:
		var direction = (global_position - source_position).normalized()
		external_velocity  = direction * force * stats.knockback_resitance

func apply_dot(dot_id: String, damage_source: DamageSource, interval: float, duration: float, refresh_if_exists := true):
	if active_dots.has(dot_id):
		if refresh_if_exists:
			# Redémarre le DoT existant
			var existing_timer_data = active_dots[dot_id]
			existing_timer_data["duration"] = existing_timer_data["elapsed"] + duration
		return

	var timer := Timer.new()
	timer.wait_time = interval
	timer.one_shot = false
	add_child(timer)

	var dot_data = {
		"timer": timer,
		"elapsed": 0.0,
		"duration": duration,
		"damage_source": damage_source,
	}
	active_dots[dot_id] = dot_data

	timer.timeout.connect(func():
		dot_data["elapsed"] += interval
		take_damage(damage_source)

		if dot_data["elapsed"] >= duration:
			timer.queue_free()
			active_dots.erase(dot_id)
	)

	timer.start()
