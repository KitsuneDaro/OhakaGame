extends Node2D

# move
const moving_able_width: float = 400
const moving_speed: float = 400
var velocity: Vector2 = Vector2(0, 0)

# rotate
const rotating_able_radians: float = PI / 2
const rotating_first_speed_radians: float = PI * 2 / 3 # 戻るスピード
const rotating_reset_rate: float = 4.0 # 戻るスピード
const rotating_decay_rate: float = 0.95 # 減衰率
const rotating_eps_radians: float = 0.005
var rotating_velocity_radians: float = 0

# human
var having_human: Human = null
var having_human_flag: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func start_game():
	create_having_human()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	move_holizon(delta)
	limit_position()
	
	rotate_by_motion(delta)
	limit_rotation()
	
	handle_having_human()


func create_having_human():
	if not having_human_flag:
		having_human = Human.create_random_human()
		having_human.collision_layer = 0
		move_having_human()
		
		get_parent().add_child(having_human)
		
		having_human_flag = true


func move_having_human():
	having_human.position = position


func release_having_human():
	having_human.collision_mask = 1
	having_human = null
	
	having_human_flag = false


func handle_having_human():
	if having_human_flag:
		move_having_human()
		
		if Input.is_action_just_pressed("ui_accept"):
			release_having_human()
			
			# 実際は着地後
			# create_having_human()


func rotate_by_motion(delta: float):
	if Input.is_action_just_pressed("ui_left"):
		rotating_velocity_radians = -rotating_first_speed_radians
	elif Input.is_action_just_pressed("ui_right"):
		rotating_velocity_radians = rotating_first_speed_radians
	elif (Input.is_action_pressed("ui_left")
		or Input.is_action_pressed("ui_right")):
		if rotation * rotating_velocity_radians > 0:
			rotating_velocity_radians = rotating_velocity_radians * rotating_decay_rate
	elif rotation != 0:
		rotating_velocity_radians = -rotation * rotating_reset_rate
	
	rotation += rotating_velocity_radians * delta


func limit_rotation():
	if rotation > rotating_able_radians / 2:
		rotation = rotating_able_radians / 2
	elif rotation < -rotating_able_radians / 2:
		rotation = -rotating_able_radians / 2
	if abs(rotation) < rotating_eps_radians:
		rotation = 0


func move_holizon(delta: float):
	if Input.is_action_pressed("ui_left"):
		velocity.x = -moving_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = moving_speed
	else:
		velocity.x = 0
	
	position += velocity * delta


func limit_position():
	if position.x > moving_able_width / 2:
		position.x = moving_able_width / 2
	elif position.x < -moving_able_width / 2:
		position.x = -moving_able_width / 2
