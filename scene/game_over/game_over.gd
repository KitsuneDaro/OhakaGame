extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals()


func connect_signals():
	$retry_button.connect("button_up", retry)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func retry():
	get_parent().change_scene("res://scene/main_game/main_game.tscn")
