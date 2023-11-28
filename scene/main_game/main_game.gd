extends Node2D

signal game_start

# Called when the node enters the scene tree for the first time.
func _ready():
	Variables.score = 0
	Variables.game_over_flag = false
	add_child(Human.last_collide_timer)
	
	connect_signals()


# シグナルの接続
func connect_signals():	
	$start_count.game_start.connect(start_game)
	game_start.connect($merge_area/god.start_game)
	
	$merge_area.game_over.connect(set_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# ゲーム開始
func start_game():
	emit_signal("game_start")


func set_game_over():
	var game_over = Scene.game_over.instantiate()
	Variables.game_over_flag = true
	add_child(game_over)
	
	$merge_area/god.set_game_over()
	$score_label.queue_free()
