extends Node

signal score_update
signal created_human
signal merged_human

var score: int = 0:
	set(new_score):
		var delta_score = new_score - score
		score = new_score
		
		emit_signal('score_update')


func _on_created_human(life_stage: int):
	created_human.emit(life_stage)


func _on_merged_human(life_stage: int):
	merged_human.emit(life_stage)
