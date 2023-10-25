extends RigidBody2D

class_name Human
signal collision_between_human

# Called when the node enters the scene tree for the first time.
func _ready():
	attach_scale()
	attach_contact()
	connect_signal()

func attach_scale():
	$collision.scale = scale
	$sprite.scale = scale
	scale = Vector2(1, 1)

func attach_contact():
	contact_monitor = true
	max_contacts_reported = 3 # 床、壁、他の人間で最大3つ必要

func connect_signal():
	body_entered.connect(_on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	pass

func _on_body_entered(body):
	if body is Human:
		if self.get_index() < body.get_index():
			emit_signal('collision_between_human', self, body)
