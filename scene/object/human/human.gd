extends RigidBody2D

class_name Human
signal collision_between_human

const human_scene_kinds: Array = [
	['none'],
	['female', 'male'],
	['female', 'male'],
	['female', 'male'],
	['female', 'male'],
	['female', 'male'],
	['female', 'male'],
	['female', 'male'],
	['none']
]
const human_scene_path: String = "res://scene/object/human/%d/%d_%s.tscn"
const human_data_path: String = "res://scene/object/human/%d/data.tres"
static var human_scenes: Array = []
static var human_datas: Array = []

# scale up
var scale_up_first_speed: float = 3.0
var scale_up_rate: float = 0.1
var origin_scale: Vector2 = scale

# time
var time: float = 0

# create
const creating_human_life_stage_rates: Array = [0.4, 0.3]
# 自然な出生性比を参考
# https://ourworldindata.org/gender-ratio
# 100 / 205
const creating_human_female_rate: float = 0.488

# merge
var merging_able_flag: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	reset_scale()
	attach_scale(scale_up_rate)
	attach_contact()
	connect_signal()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if scale_up_rate != 1:
		time += delta
		scale_up()
		attach_scale(scale_up_rate)


# スケールの初期化
func reset_scale():
	scale= Vector2(1, 1)


# スケールの設定
func attach_scale(scale_rate: float = 1.0):
	$collision.scale = origin_scale * scale_rate
	$sprite.scale = origin_scale * scale_rate


# 接触の設定
func attach_contact():
	contact_monitor = true
	max_contacts_reported = 10 # 床、壁、他の人間で最大3つ必要


# シグナルの接続
func connect_signal():
	body_entered.connect(_on_body_entered)
	collision_between_human.connect(_on_collision_between_human)


# 拡大
func scale_up():
	if scale_up_rate < 1:
		scale_up_rate += time * scale_up_first_speed
	else:
		scale_up_rate = 1


# 人間シーンのロード
static func load_humans():
	for life_stage in range(len(human_scene_kinds)):
		var kinds: Array = human_scene_kinds[life_stage]
		var kind_scenes: Dictionary = {}
		
		for kind in kinds:
			kind_scenes[kind] = load(human_scene_path % [life_stage, life_stage, kind])
		
		human_scenes.push_back(kind_scenes)
		
		var human_data = load(human_data_path % life_stage)
		print(human_data_path % life_stage, human_data)
		human_datas.push_back(human_data)


# 指定した人間を作る
static func create_human(life_stage: int, gender: String):
	if not Human.is_correct_human(life_stage, gender):
		return null
	
	var human: Human = Human.human_scenes[life_stage][gender].instantiate()
	return human


# ランダムに人間を作る
static func create_random_human() -> Human:
	# life_stage
	var life_stage: int = get_random_life_stage()
	
	# gender
	var gender: String = 'none'
	
	if human_scene_kinds[life_stage].has('none'):
		gender = 'none'
	else:
		gender = get_random_gender()
	
	var human: Human = human_scenes[life_stage][gender].instantiate()
	
	return human


# ランダムなライフステージを作る
static func get_random_life_stage() -> int:
	var life_stage_prob: float = 0
	var life_stage: int = len(creating_human_life_stage_rates)
	var uniform_prob: float = 0
	
	uniform_prob = randf()
	
	for new_life_stage in range(len(creating_human_life_stage_rates)):
		var rate = creating_human_life_stage_rates[new_life_stage]
		life_stage_prob += rate
		
		if uniform_prob < life_stage_prob:
			life_stage = new_life_stage
			break
	
	return life_stage


# ランダムな性別を作る
static func get_random_gender() -> String:
	var uniform_prob = randf()
	
	if uniform_prob < creating_human_female_rate:
		return 'female'
	else:
		return 'male'


# 人間のパラメータとして適切か
static func is_correct_human(life_stage: int, gender: String) -> bool:
	if (life_stage < len(human_scene_kinds)
	and human_scene_kinds[life_stage].has(gender)):
		return true
	
	return false


# 人間が合体できるか
static func is_merge_able_humans(human1: Human, human2: Human) -> bool:
	return (
		human1.life_stage == human2.life_stage
		and human1.gender == human2.gender
		and human1.life_stage < len(human_scene_kinds) - 1
		and human1.merging_able_flag
		and human2.merging_able_flag
		)


# ぶつかったとき
func _on_body_entered(body: RigidBody2D):
	if body is Human:
		var human1: Human = self
		var human2: Human = body
		
		if (human1.get_index() < human2.get_index()
		and is_merge_able_humans(human1, human2)):
			merge_humans(human1, human2)

func merge_humans(human1: Human, human2: Human):
	# 同時に合体を防ぐ
	human1.merging_able_flag = false
	human2.merging_able_flag = false
	
	emit_signal('collision_between_human', human1, human2)


# 人間の合体
func _on_collision_between_human(human1: Human, human2: Human):
	# ボディの追加
	var life_stage: int = human1.life_stage + 1
	
	var humans: Dictionary = Human.human_scenes[life_stage]
	var human_genders: Array = Human.human_scene_kinds[life_stage]
	var human_gender: String = ''
	
	if human_genders.has('none'):
		human_gender = 'none'
	else:
		if human1.gender == 'none':
			human_gender = get_random_gender()
		else:
			human_gender = human1.gender
	
	var human: Human = Human.create_human(life_stage, human_gender)
	human.position = (human2.position + human1.position) / 2
	human.rotate((human2.position - human1.position).angle() + PI / 2)
	
	get_parent().add_child(human)
	
	# ボディの消去
	human1.queue_free()
	human2.queue_free()
	
	# スコア加点
	Variables.score += get_score(life_stage)


# 人間のスコアを得る
static func get_score(life_stage: int) -> int:
	return human_datas[life_stage].score
