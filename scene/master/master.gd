extends Node2D

signal scene_change_finished

const scene_change_scene: PackedScene = preload("res://scene/change_scene/change_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Human.load_humans()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_scene(scene_path: String, delete_node: Node):
	var scene_change_node: Node = scene_change_scene.instantiate()
	add_child(scene_change_node)
	
	scene_change_node.start_cover_scene()
	await scene_change_node.coverd
	
	var load_node_name: String = delete_node.name
	delete_node.queue_free()
	
	var load_node: Node = load(scene_path).instantiate()
	add_child(load_node)
	
	scene_change_node.start_uncover_scene()
	await scene_change_node.uncoverd
	
	load_node.name = load_node_name
	
	scene_change_node.queue_free()
	emit_signal("scene_change_finished")
