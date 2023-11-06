extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func connect_signals():
	$over_zone.connect("game_over", game_over)
	$over_zone.connect("body_enter", _on_over_zone_enter)
	$over_zone.connect("all_bodies_exit", _on_over_zone_exit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	pass


func _on_over_zone_enter():
	$god.releasing_able_flag = false


func _on_over_zone_exit():
	$god.releasing_able_flag = true
