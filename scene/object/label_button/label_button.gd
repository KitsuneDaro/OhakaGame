@tool
extends Button

@export var origin_position: Vector2:
	set(new_origin_posiition):
		origin_position = new_origin_posiition
		attach_position()

@export var origin_size: Vector2:
	set(new_origin_size):
		origin_size = new_origin_size
		attach_size()

@export var label_text: String:
	set(new_label_text):
		label_text = new_label_text
		attach_text()

@export var label_font: Font:
	set(new_label_font):
		label_font = new_label_font
		attach_font()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func attach_position():
	position = origin_position - origin_size / 2


func attach_size():
	size = origin_size
	if get_node("./label"):
		get_node("./label").size = size


func attach_text():
	if get_node("./label"):
		get_node("./label").text = label_text


func attach_font():
	if get_node("./label"):
		get_node("./label").label_settings.font = label_font

