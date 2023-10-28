extends Node2D

signal game_start

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals()


# シグナルの接続
func connect_signals():
	$start_count.connect("game_start", start_game)
	connect("game_start", $merge_area/god.start_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# ゲーム開始
func start_game():
	emit_signal("game_start")
