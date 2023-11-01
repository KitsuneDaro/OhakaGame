extends Area2D

signal game_over

var entered_human_num: int = 0
var over_timer_waiting_time: float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals()
	set_over_timer()


func connect_signals():
	connect("body_entered", _on_body_enterd)
	connect("body_exited", _on_body_exited)


func set_over_timer():
	$over_timer.wait_time = over_timer_waiting_time
	$over_timer.one_shot = true
	$over_timer.timeout.connect(time_out_of_over_timer)


func time_out_of_over_timer():
	emit_signal("game_over")


func _on_body_enterd(body):
	if body is Human:
		entered_human_num += 1
		
		if entered_human_num == 1:
			$over_timer.start()


func _on_body_exited(body):
	if body is Human:
		entered_human_num -= 1
		
		if entered_human_num == 0:
			$over_timer.stop()
