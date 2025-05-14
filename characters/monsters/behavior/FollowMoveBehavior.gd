extends MonsterMoveBehavior
class_name FollowMoveBehavior

@export var look_at_player: bool = false

func move(_monster: Monster, _delta: float) -> void:
	var player_pos := _monster.player.global_position
	var _monster_pos := _monster.global_position
	var to_player := player_pos - _monster_pos
	var dist_squared := to_player.length_squared()

	if dist_squared > 9.0: # 3 * 3
		var dir := to_player / sqrt(dist_squared)
		_monster.velocity = dir * _monster.stats.speed + _monster.external_velocity
	else:
		_monster.velocity = Vector2.ZERO
	
	_monster.look_at_player()

	if(look_at_player):
		_monster.look_at(_monster.player.global_position)
		_monster.get_node("Sprite2D").flip_h = true
