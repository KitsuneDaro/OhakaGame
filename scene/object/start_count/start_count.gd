extends Node2D

signal game_start

var second_count: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	set_counting_labels()
	set_second_timer()


func set_second_timer():
	$second_counter.timeout.connect(count)
	$second_counter.wait_time = 1.0
	$second_counter.one_shot = false
	$second_counter.start()

func set_counting_labels():
	second_count = 3
	
	for second in range(3):
		change_counting_label(second, false)
	
	change_counting_label(3, true)


func change_counting_label(second: int, visible_flag: bool):
	if second >= 0 and second <= 3:
		var label_name = get_counting_label_name(second)
		get_node(label_name).visible = visible_flag


func get_counting_label_name(second: int):
	if second == 0:
		return 'start_label'
	else:
		return '%d_label' % second


func count():
	change_counting_label(second_count, false)
	
	if second_count == 0:
		$second_counter.stop()
		emit_signal('game_start')
	else:
		second_count -= 1
		
		change_counting_label(second_count, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
