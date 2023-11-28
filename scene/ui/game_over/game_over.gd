extends Control

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
	get_node("/root/master").sound("res://util/music/効果音ブン.mp3")


func retry_game():
	get_node("/root/master").sound("res://util/music/効果音ブン.mp3")
	change_scene(Scene.main_game)


func go_to_title():
	get_node("/root/master").sound("res://util/music/効果音ブン.mp3")
	change_scene(Scene.title)
