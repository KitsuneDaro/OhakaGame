extends Node2D

const scene_change_scene: PackedScene = preload("res://scene/change_scene/change_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Human.load_humans()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_scene(scene_path: String):
	var scene_change: Node = scene_change_scene.instantiate()
	add_child(scene_change)
	await scene_change.#完了するまで
