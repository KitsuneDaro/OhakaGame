extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals()
	update_score()


func connect_signals():
	Variables.score_update.connect(update_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_score():
	text = 'スコア:' + str(Variables.score)
