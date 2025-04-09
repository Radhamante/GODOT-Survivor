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
	move_and_slide()
	
func move(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * consts.SPEED
	
	

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
	
