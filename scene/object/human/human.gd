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
const human_path: String = "res://scene/object/human/%d/%d_%s.tscn"
static var human_scenes: Array = []

# scale up
var scale_up_first_speed: float = 3.0
var scale_up_rate: float = 0.1
var origin_scale: Vector2 = scale

# time
var time: float = 0

# create
const creating_human_life_stage_rates: Array = [
	0.4, 0.3
]
# 自然な出生性比を参考
# https://ourworldindata.org/gender-ratio
const creating_human_female_rate: float = 100 / 205

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_scale()
	attach_scale()
	attach_contact()
	connect_signal()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	time += delta
	scale_up()
	attach_scale(scale_up_rate)


func reset_scale():
	scale= Vector2(1, 1)


func attach_scale(scale_rate: float = 1.0):
	$collision.scale = origin_scale * scale_rate
	$sprite.scale = origin_scale * scale_rate


func attach_contact():
	contact_monitor = true
	max_contacts_reported = 3 # 床、壁、他の人間で最大3つ必要


func connect_signal():
	body_entered.connect(_on_body_entered)


func scale_up():
	if scale_up_rate < 1:
		scale_up_rate += time * scale_up_first_speed
	else:
		scale_up_rate = 1


func _on_body_entered(body: RigidBody2D):
	if body is Human:
		if self.get_index() < body.get_index():
			emit_signal('collision_between_human', self, body)


# 人間シーンのロード
static func load_humans():
	for life_stage in range(len(human_scene_kinds)):
		var kinds: Array = human_scene_kinds[life_stage]
		var kind_scenes: Dictionary = {}
		
		for kind in kinds:
			kind_scenes[kind] = load(human_path % [life_stage, life_stage, kind])
		
		human_scenes.push_back(kind_scenes)


static func create_human() -> Human:
	# life_stage
	var life_stage_prob: float = 0
	var life_stage: int = 0
	var uniform_prob: float = 0
	
	uniform_prob = randf()
	
	for new_life_stage in range(len(creating_human_life_stage_rates)):
		var rate = creating_human_life_stage_rates[new_life_stage]
		life_stage_prob += rate
		
		if uniform_prob < life_stage_prob:
			life_stage = new_life_stage
	
	# gender
	var gender: String = 'none'
	
	uniform_prob = randf()
	
	if uniform_prob < creating_human_female_rate:
		gender = 'female'
	else:
		gender = 'male'
	
	var human = Human.new()
	
	if human_scene_kinds[life_stage].has(gender):
		human = human_scenes[life_stage][gender]
	else:
		human = human_scenes[life_stage]['none']
		human.gender = gender
	
	return human


# 人間のパラメータとして適切か
static func is_correct_human(life_stage: int, gender: String) -> bool:
	if life_stage < len(human_scene_kinds):
		if human_scene_kinds[life_stage].has(gender):
			return true
	
	return false


static func is_merge_able_humans(human1: Human, human2: Human) -> bool:
	return human1.life_stage == human2.life_stage and human1.life_stage < len(human_scene_kinds) - 1
