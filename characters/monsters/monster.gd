extends CharacterBody2D
class_name Monster


@onready var player: CharacterBody2D = get_node("/root/Game/Player")
@onready var animation: AnimationPlayer = get_node("AnimationPlayer")
@onready var consts = get_node("Const")
var health: float

func _ready() -> void:
	health = consts.HEALTH
	animation.queue("Move")

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
		velocity = direction * consts.SPEED
	else:
		velocity = Vector2.ZERO
	look_at_player()
		
func look_at_player():
	if player.global_position.x < global_position.x:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
	

func take_damage(damage: float):
	health-=damage
	animation.play("hurt")
	animation.queue("Move")
	if health <= 0:
		queue_free()
		const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		smoke.global_position = global_position
		get_parent().add_child(smoke)
	
