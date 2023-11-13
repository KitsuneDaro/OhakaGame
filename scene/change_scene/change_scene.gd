extends Node

var cover_flag: bool = false
var cover_time: float = 0
@export var cover_max_time: float = 0.5

var uncover_flag: bool = false
var uncover_time: float = 0
@export var uncover_max_time: float = 0.5

@export var ease_curve: Curve

# Called when the node enters the scene tree for the first time.
func _ready():
	set_black_out_position(Vector2(0, 0))
	cover_scene()


func set_black_out_position(new_position: Vector2):
	$black_out.position = new_position - get_viewport().size * 0.5


func set_black_out_x(new_x: float):
	$black_out.position.x = new_x - get_viewport().size.x * 0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cover_flag or uncover_flag:
		var width = get_viewport().size.x
		
		if cover_flag:
			var sample_point = cover_time / cover_max_time
			set_black_out_x((1 - ease_curve.sample(sample_point)) * width)
			
			cover_time += delta
			
			if cover_time > cover_max_time:
				cover_flag = false
				set_black_out_x(0)
		
		if uncover_flag:
			var sample_point = uncover_time / uncover_max_time
			set_black_out_x(-ease_curve.sample(sample_point) * width)
			uncover_time += delta
			
			if uncover_time > uncover_max_time:
				uncover_flag = false
				set_black_out_x(-width)


func cover_scene():
	var width = get_viewport().size.x
	cover_flag = true
	cover_time = 0
	set_black_out_x(width)


func uncover_scene():
	uncover_flag = true
	uncover_time = 0
	set_black_out_x(0)
