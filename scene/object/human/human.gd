extends RigidBody2D

class_name Human
signal collision_between_human

var scale_up_first_speed: float = 3.0
var scale_up_rate: float = 0.1

var time: float = 0
var origin_scale: Vector2 = scale

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_scale()
	attach_scale()
	attach_contact()
	connect_signal()

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	time += delta
	scale_up()
	attach_scale(scale_up_rate)


func scale_up():
	if scale_up_rate < 1:
		scale_up_rate += time * scale_up_first_speed
	else:
		scale_up_rate = 1


func _on_body_entered(body: RigidBody2D):
	if body is Human:
		if self.get_index() < body.get_index():
			emit_signal('collision_between_human', self, body)
