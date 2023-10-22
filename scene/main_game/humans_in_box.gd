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


func connect_signal_of_human(body: human):
	body.collision_between_human.connect(_on_collision_between_human)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_collision_between_human(body1: human, body2: human):
	if body1.life_stage == body2.life_stage:
		# ボディの追加
		var next_life_stage: int = body1.life_stage + 1
		
		var next_humans: Dictionary = human_scenes[next_life_stage]
		var next_human_genders: Array = next_humans.keys()
		var next_human_gender: String = ''
		next_human_gender = next_human_genders[randi_range(0, len(next_human_genders) - 1)]
		
		var next_human: human = next_humans[next_human_gender].instantiate()
		next_human.position = (body2.position + body1.position) / 2
		next_human.rotate((body2.position - body1.position).angle() + PI / 2)
		
		# シグナルの接続
		next_human.connect_signal()
		connect_signal_of_human(next_human)
		
		add_child(next_human)
		
		# ボディの消去
		body1.queue_free()
		body2.queue_free()
