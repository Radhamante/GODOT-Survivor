extends Node
class_name DifficultyManager

signal difficulty_changed(difficulty_level: DifficultyLevel)

var elapsed_time: float = 0.0
var applied_times: Array = []

var difficulty_levels : DifficultyLevels
var current_difficulty_level: DifficultyLevel

signal timer_updated(elapsed_time: float, applied_times: Array)

func _process(delta: float) -> void:
	elapsed_time += delta
	emit_signal("timer_updated", elapsed_time, applied_times)
	_check_for_next_difficulty()


func _check_for_next_difficulty():
	for t in difficulty_levels.levels.keys():
		if elapsed_time >= t and not applied_times.has(t):
			applied_times.append(t)
			current_difficulty_level = difficulty_levels.levels[t]
			difficulty_changed.emit(current_difficulty_level)
