extends MonsterMoveBehavior
class_name FollowMoveBehavior

@export var look_at_player: bool = false

func move(monster: Monster, delta: float) -> void:
	var player_pos := monster.player.global_position
	var monster_pos := monster.global_position
	var to_player := player_pos - monster_pos
	var dist_squared := to_player.length_squared()

	if dist_squared > 9.0: # 3 * 3
		var dir := to_player / sqrt(dist_squared)
		monster.velocity = dir * monster.stats.speed + monster.external_velocity
	else:
		monster.velocity = Vector2.ZERO
	
	monster.look_at_player()

	if(look_at_player):
		monster.look_at(monster.player.global_position)
		monster.get_node("Sprite2D").flip_h = true
