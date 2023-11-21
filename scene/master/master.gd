extends Node2D

signal scene_change_finished

const scene_change_scene: PackedScene = preload("res://scene/change_scene/change_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Human.load_humans()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_scene(next_scene: PackedScene, delete_node: Node):
	var scene_change_node: Node = scene_change_scene.instantiate()
	add_child(scene_change_node)
	
	scene_change_node.start_cover_scene()
	await scene_change_node.coverd
	
	var next_scene_node_name: String = delete_node.name
	delete_node.queue_free()
	
	var next_scene_node: Node = next_scene.instantiate()
	add_child(next_scene_node)
	
	scene_change_node.start_uncover_scene()
	await scene_change_node.uncoverd
	
	next_scene_node.name = next_scene_node_name
	
	scene_change_node.queue_free()
	emit_signal("scene_change_finished")
