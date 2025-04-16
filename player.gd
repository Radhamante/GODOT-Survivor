extends CharacterBody2D

signal heath_depleted

var health = 100.0

func _ready() -> void:
	Variables.Player = self

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * 600
	
	move_and_slide()
	
	if(velocity.length() > 0):
		%Alien.play_walk_animation()
	else: 
		%Alien.play_idle_animation()

	var overlapping_mobs: Array[Node2D] = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		var overlapping_damages = overlapping_mobs.reduce(func (sum, next): return sum + next.stats.damage, 0)
		health -= overlapping_damages * delta
		%ProgressBar.value = health
		if health <= 0:
			heath_depleted.emit()
