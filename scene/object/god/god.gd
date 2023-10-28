extends Node2D

# move
var move_able_width = 400
var move_speed = 400
var velocity = Vector2(0, 0)

# rotate
var rotate_able_radians: float = PI / 2
var rotate_first_speed_radians: float = PI * 2 / 3 # 戻るスピード
var rotate_reset_rate: float = 4.0 # 戻るスピード
var rotate_decay_rate: float = 0.95 # 減衰率
var rotate_eps_radians: float = 0.005
var rotate_velocity_radians: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	move_holizon(delta)
	rotate_by_move(delta)
	limit_position()
	limit_rotate()
	
	pass


func rotate_by_move(delta: float):
	if Input.is_action_just_pressed("ui_left"):
		rotate_velocity_radians = -rotate_first_speed_radians
	elif Input.is_action_just_pressed("ui_right"):
		rotate_velocity_radians = rotate_first_speed_radians
	elif (Input.is_action_pressed("ui_left")
		or Input.is_action_pressed("ui_right")):
		if rotation * rotate_velocity_radians > 0:
			rotate_velocity_radians = rotate_velocity_radians * rotate_decay_rate
	elif rotation != 0:
		rotate_velocity_radians = -rotation * rotate_reset_rate
	
	rotation += rotate_velocity_radians * delta


func limit_rotate():
	if rotation > rotate_able_radians / 2:
		rotation = rotate_able_radians / 2
	elif rotation < -rotate_able_radians / 2:
		rotation = -rotate_able_radians / 2
	if abs(rotation) < rotate_eps_radians:
		rotation = 0


func move_holizon(delta: float):
	if Input.is_action_pressed("ui_left"):
		velocity.x = -move_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = move_speed
	else:
		velocity.x = 0
	
	position += velocity * delta


func limit_position():
	if position.x > move_able_width / 2:
		position.x = move_able_width / 2
	elif position.x < -move_able_width / 2:
		position.x = -move_able_width / 2
