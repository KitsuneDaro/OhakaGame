extends Node2D

# move
var move_able_width = 400
var move_speed = 150

# rotate
var max_rotate_radians = PI / 3
var rotate_reset_speed_radians = PI / 3 # 戻るスピード
var rotate_radians = 0
var rotate_velocity_radians = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_holizon(delta)
	limit_position()
	
	pass


func eval_rotate_radians():
	
	pass


func move_holizon(delta):
	if Input.is_action_pressed("ui_left"):
		position.x -= move_speed * delta
	if Input.is_action_pressed("ui_right"):
		position.x += move_speed * delta


func limit_position():
	if position.x > move_able_width / 2:
		position.x = move_able_width / 2
	elif position.x < -move_able_width / 2:
		position.x = -move_able_width / 2
