extends Area2D

signal game_over
signal all_bodies_exit

var entered_human_num: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals()
	set_over_timer()


func connect_signals():
	connect("body_entered", _on_body_enterd)
	connect("body_exited", _on_body_exited)


func set_over_timer():
	$over_timer.wait_time = Variables.over_timer_max_waiting_time
	$over_timer.one_shot = true
	$over_timer.timeout.connect(time_out_of_over_timer)


func _process(delta):
	if Variables.over_area_flag and not Variables.game_over_flag:
		Variables.over_area_time += delta
	else:
		Variables.over_area_time = 0.0


func time_out_of_over_timer():
	Variables.over_area_time = 0.0
	emit_signal("game_over")


func _on_body_enterd(body):
	if body is Human:
		entered_human_num += 1
		
		if entered_human_num == 1:
			$over_timer.start()
			Variables.over_area_flag = true


func _on_body_exited(body):
	if body is Human:
		entered_human_num -= 1
		
		if entered_human_num == 0:
			$over_timer.stop()
			emit_signal("all_bodies_exit")
			Variables.over_area_flag = false
