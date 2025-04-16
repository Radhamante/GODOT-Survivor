extends MonsterMoveBehavior
class_name JumpMoveBehavior

@export var jump_cooldown := 0.5
@export var jump_duration := 0.5
var jump_timer := 0.0
var is_jumping := false

func move(monster: Monster, delta: float) -> void:
	jump_timer -= delta
	monster.look_at_player()

	if is_jumping:
		if jump_timer <= 0.0:
			is_jumping = false
			jump_timer = jump_cooldown
			monster.velocity = Vector2.ZERO + monster.external_velocity
	else:
		if jump_timer <= 0.0:
			monster.animation.play("Move")
			var direction = monster.global_position.direction_to(monster.player.global_position)
			monster.velocity = direction * monster.stats.speed + monster.external_velocity
			is_jumping = true
			jump_timer = jump_duration
			monster.animation.queue("idle")
