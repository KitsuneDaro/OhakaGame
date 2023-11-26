extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals()


func connect_signals():
	Variables.created_human.connect(update_history)
	Variables.merged_human.connect(update_history)


func update_history(life_stage):
	var score_up_text = Human.human_datas[life_stage].score_up_text
	var score = Human.human_datas[life_stage].score
	$score_up_label.text = $score_up_label.text.insert(3, '\n' + score_up_text)
	$score_label.text = $score_label.text.insert(3, '\n' + str(score))
