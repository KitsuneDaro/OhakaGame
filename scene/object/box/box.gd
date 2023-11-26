@tool

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals()


func connect_signals():
	$primitive2d.size_changed.connect(_on_size_changed)


func _on_size_changed():
	$primitive2d.size / 2
	pass
