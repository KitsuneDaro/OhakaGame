extends Node

signal score_update
signal created_human
signal merged_human
signal enter_over_area
signal exit_over_area

var score: int = 0:
	set(new_score):
		var delta_score = new_score - score
		score = new_score
		
		score_update.emit()

var over_area_time: float = 0.0
var over_area_flag: bool = false:
	set(new_over_area_flag):
		over_area_flag = new_over_area_flag
		if over_area_flag:
			enter_over_area.emit()
		else:
			over_area_time = 0.0
			exit_over_area.emit()
const over_timer_max_waiting_time: float = 2.0

var game_over_flag: bool = false

func _on_created_human(life_stage: int):
	created_human.emit(life_stage)


func _on_merged_human(life_stage: int):
	merged_human.emit(life_stage)
