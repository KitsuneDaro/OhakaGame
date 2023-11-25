extends Node

signal score_update

var score: int = 0:
	set(new_score):
		score = new_score
		print('update')
		emit_signal('score_update')
