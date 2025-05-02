extends VBoxContainer

@onready var timer_label: Label = $TimerLabel
@onready var difficulty_label: Label = $DifficultyLabel
@onready var level_label: Label = $LevelLabel

func update_display(elapsed: float, applied_times: Array):
	timer_label.text = "Time: %.0f s" % elapsed
	difficulty_label.text = "Difficulty: %d" % applied_times.size() 

func _on_difficulty_manager_timer_updated(elapsed_time: float, applied_times: Array) -> void:
	update_display(elapsed_time, applied_times)


func _on_player_xp_level(xp: float, level: int, xp_for_next_level: float) -> void:
	if level_label:
		level_label.text = "Level : " + str(level)
