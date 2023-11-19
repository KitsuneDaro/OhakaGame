extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals()


func connect_signals():
	$share_button.connect("button_up", share)
	$retry_button.connect("button_up", retry)
	$title_button.connect("button_up", title)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_scene(next_scene_path: String):
	var master_node: Node = get_node("/root/master")
	var main_game_node: Node = get_parent()
	
	master_node.change_scene(next_scene_path, main_game_node)
	#await master_node.scene_change_finished


func share():
	const text: String = 'おはかゲームでスコア%d点を記録しました！\nみんなもお墓づくりに挑戦しよう！'
	Twitter.share(text % Variables.score)


func retry():
	var next_scene_path: String = "res://scene/main_game/main_game.tscn"
	change_scene(next_scene_path)


func title():
	var next_scene_path: String = "res://scene/title/title.tscn"
	change_scene(next_scene_path)
