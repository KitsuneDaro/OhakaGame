extends Control

const main_game_scene: PackedScene = preload("res://scene/main_game/main_game.tscn")
const title_scene: PackedScene = preload("res://scene/title/title.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals()


func connect_signals():
	$share_button.connect("button_up", share_on_twitter)
	$retry_button.connect("button_up", retry_game)
	$title_button.connect("button_up", go_to_title)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_scene(next_scene: PackedScene):
	var master_node: Node = get_node("/root/master")
	var main_game_node: Node = get_parent()
	
	master_node.change_scene(next_scene, main_game_node)
	#await master_node.scene_change_finished


func share_on_twitter():
	const text: String = 'おはかゲームでスコア%d点を記録しました！\nみんなもお墓づくりに挑戦しよう！'
	Twitter.share(text % Variables.score)


func retry_game():
	change_scene(main_game_scene)


func go_to_title():
	change_scene(title_scene)
