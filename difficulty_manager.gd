extends Node
class_name DifficultyManager

signal difficulty_changed(modifiers: Array)

var elapsed_time: float = 0.0
var applied_times: Array = []

var difficulty_levels := {
	0.0: [],
	10.0: [MultMonsterModifier.new("health", 1.2)],
	60.0: [
		FlatMonsterModifier.new("armor", 1.0),
		MultMonsterModifier.new("health", 1.4),
	],
	120.0: [
		FlatMonsterModifier.new("health", 1),
		MultMonsterModifier.new("health", 1.5), 
		MultMonsterModifier.new("damage", 1.5)
	],
	150.0: [
		FlatMonsterModifier.new("health", 1),
		MultMonsterModifier.new("health", 2.25),
		MultMonsterModifier.new("damage", 2.0),
	],
}

var active_modifiers: Array[MonsterModifier] = []

func _process(delta: float) -> void:
	elapsed_time += delta
	_check_for_next_difficulty()

func _check_for_next_difficulty():
	for t in difficulty_levels.keys():
		if elapsed_time >= t and not applied_times.has(t):
			applied_times.append(t)
			
			active_modifiers.clear()
			for mod in difficulty_levels[t]:
				if mod is MonsterModifier:
					active_modifiers.append(mod)
			
			emit_signal("difficulty_changed", active_modifiers)
			print("Difficulty increased at ", t, "s: ", active_modifiers)
