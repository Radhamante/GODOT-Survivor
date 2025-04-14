extends Monster

var jump_cooldown := 0.5
var jump_duration := 0.5
var jump_timer := 0.0
var is_jumping := false

func _ready() -> void:
	super._ready()
	animation.play("idle")

func move(delta: float) -> void:
	look_at_player()
	jump_timer -= delta
	
	if is_jumping:
		if jump_timer <= 0.0:
			is_jumping = false
			jump_timer = jump_cooldown
			velocity = Vector2.ZERO
	else:
		if jump_timer <= 0.0:
			animation.play("Move")
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * consts.SPEED * 2.0
			is_jumping = true
			jump_timer = jump_duration
			animation.queue("idle")
