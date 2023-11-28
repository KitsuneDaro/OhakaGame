extends Node2D

signal game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals()


func connect_signals():
	$over_zone.connect("game_over", set_game_over)
	$over_zone.connect("body_enter", _on_over_zone_enter)
	$over_zone.connect("all_bodies_exit", _on_over_zone_exit)


func set_game_over():
	emit_signal("game_over")


func _on_over_zone_enter():
	$god.releasing_able_flag = false


func _on_over_zone_exit():
	$god.releasing_able_flag = true
