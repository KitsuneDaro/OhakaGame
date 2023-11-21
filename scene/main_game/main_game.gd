extends Node2D

signal game_start

const game_over_scene = preload("res://scene/ui/game_over/game_over.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Variables.score = 0
	connect_signals()


# シグナルの接続
func connect_signals():
	$start_count.connect("game_start", start_game)
	connect("game_start", $merge_area/god.start_game)
	
	$merge_area.connect("game_over", set_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# ゲーム開始
func start_game():
	emit_signal("game_start")


func set_game_over():
	var game_over = game_over_scene.instantiate()
	add_child(game_over)
	
	$merge_area/god.set_game_over()
