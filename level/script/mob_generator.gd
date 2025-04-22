extends Node

var mobs = []
var monster_modifiers: Array[MonsterModifier]

func spawn_mod():
	if mobs.size() == 0:
		return
		
	var new_mod: Monster = mobs.pick_random().instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mod.global_position = %PathFollow2D.global_position
	new_mod.modifiers = monster_modifiers
	add_child(new_mod)
	new_mod.apply_modifiers()
		
	
func update_difficulty_level(difficulty_level: DifficultyLevel):
	$Timer.wait_time = difficulty_level.monster_spawn_delay
	mobs.clear()
	for monster in difficulty_level.monsters:
		if not monster:
			continue
		mobs.push_back(monster.duplicate(true))
	monster_modifiers.clear()
	for modifier in difficulty_level.monster_modifiers:
		monster_modifiers.push_back(modifier.duplicate(true))
	
