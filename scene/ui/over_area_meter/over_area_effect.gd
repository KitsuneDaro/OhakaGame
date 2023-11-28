extends ColorRect

@export var alpha_curve: Curve = null

# Called when the node enters the scene tree for the first time.
func _ready():
	position = -get_viewport().size / 2
	color.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Variables.over_area_flag:
		var over_time_ratio = Variables.over_area_time / Variables.over_timer_max_waiting_time
		
		color.a = alpha_curve.sample(over_time_ratio)
	elif not Variables.game_over_flag:
		color.a = 0.0
