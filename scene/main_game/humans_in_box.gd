extends Node2D

const human_scenes: Array = [
	{'none': preload("res://scene/object/human/0/0.tscn")},
	{
		'female': preload("res://scene/object/human/1/1_female.tscn"),
		'male': preload("res://scene/object/human/1/1_male.tscn")
	},
	{
		'female': preload("res://scene/object/human/2/2_female.tscn"),
		'male': preload("res://scene/object/human/2/2_male.tscn")
	},
	{
		'female': preload("res://scene/object/human/3/3_female.tscn"),
		'male': preload("res://scene/object/human/3/3_male.tscn")
	}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func connect_signal_of_human(body: Human):
	body.collision_between_human.connect(_on_collision_between_human)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func is_correct_human(life_stage: int, gender: String) -> bool:
	if life_stage < len(human_scenes):
		if human_scenes[life_stage].has(gender):
			return true
	
	return false


func create_human(life_stage: int, gender: String):
	if not is_correct_human(life_stage, gender):
		return null
	
	var new_human = human_scenes[life_stage][gender].instantiate()
	
	# シグナルの接続
	connect_signal_of_human(new_human)
	
	return new_human


func _on_collision_between_human(body1: Human, body2: Human):
	if body1.life_stage == body2.life_stage:
		# ボディの追加
		var next_life_stage: int = body1.life_stage + 1
		
		var next_humans: Dictionary = human_scenes[next_life_stage]
		var next_human_genders: Array = next_humans.keys()
		var next_human_gender: String = ''
		next_human_gender = next_human_genders[randi_range(0, len(next_human_genders) - 1)]
		
		var next_human: Human = create_human(next_life_stage, next_human_gender)
		next_human.position = (body2.position + body1.position) / 2
		next_human.rotate((body2.position - body1.position).angle() + PI / 2)
		
		add_child(next_human)
		
		# ボディの消去
		body1.queue_free()
		body2.queue_free()
