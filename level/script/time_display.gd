extends VBoxContainer

@onready var timer_label: Label = $TimerLabel
@onready var difficulty_label: Label = $DifficultyLabel

func update_display(elapsed: float, applied_times: Array):
	timer_label.text = "Time: %.2f s" % elapsed
	difficulty_label.text = "Difficulty: %d" % applied_times.size() 


func _on_difficulty_manager_timer_updated(elapsed_time: float, applied_times: Array) -> void:
	update_display(elapsed_time, applied_times)
	pass # Replace with function body.
