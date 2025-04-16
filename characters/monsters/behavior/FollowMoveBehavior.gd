extends MonsterMoveBehavior
class_name FollowMoveBehavior

@export var look_at_player: bool = false

func move(monster: Monster, delta: float) -> void:
	var dir = monster.global_position.direction_to(monster.player.global_position)
	var dist = monster.global_position.distance_to(monster.player.global_position)
	if dist > 3:
		monster.velocity = dir * monster.stats.speed + monster.external_velocity
	else:
		monster.velocity = Vector2.ZERO
	monster.look_at_player()

	if(look_at_player):
		monster.look_at(monster.player.global_position)
		monster.get_node("Sprite2D").flip_h = true
