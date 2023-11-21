extends Control

const main_game_scene: PackedScene = preload("res://scene/main_game/main_game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals()

func connect_signals():
	$start_button.connect("button_up", start_game)
	$explanation_button.connect("button_up", explain_game)
	#$option_button.connect("button_up", go_to_option)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_scene(next_scene: PackedScene):
	var master_node: Node = get_node("/root/master")
	var title_node: Node = self
	
	master_node.change_scene(next_scene, title_node)


func start_game():
	change_scene(main_game_scene)
	print('hi')


func explain_game():
	print('oh')
	pass


func go_to_option():
	pass
