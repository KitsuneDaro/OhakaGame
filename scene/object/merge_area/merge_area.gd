extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals_of_human_in_box()


# シグナルの接続
func connect_signals_of_human_in_box():
	for object in get_children():
		if object is Human:
			connect_signal_of_human(object)


func connect_signal_of_human(body: Human):
	body.collision_between_human.connect(_on_collision_between_human)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func create_human(life_stage: int, gender: String):
	if not Human.is_correct_human(life_stage, gender):
		return null
	
	var new_human = Human.human_scenes[life_stage][gender].instantiate()
	
	connect_signal_of_human(new_human)
	
	return new_human


func _on_collision_between_human(human1: Human, human2: Human):
	if Human.is_merge_able_humans(human1, human2):
		# ボディの追加
		var next_life_stage: int = human1.life_stage + 1
		
		var next_humans: Dictionary = Human.human_scenes[next_life_stage]
		var next_human_genders: Array = Human.human_scene_kinds[next_life_stage]
		var next_human_gender: String = ''
		next_human_gender = next_human_genders[randi_range(0, len(next_human_genders) - 1)]
		
		var next_human: Human = create_human(next_life_stage, next_human_gender)
		next_human.position = (human2.position + human1.position) / 2
		next_human.rotate((human2.position - human1.position).angle() + PI / 2)
		
		add_child(next_human)
		
		# ボディの消去
		human1.queue_free()
		human2.queue_free()
