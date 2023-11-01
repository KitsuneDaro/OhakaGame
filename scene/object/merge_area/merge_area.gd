extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func connect_signals():
	$over_zone.connect("game_over", game_over)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	pass
