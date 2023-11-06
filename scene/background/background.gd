extends Sprite2D

@export var rotation_speed: float = 1.0 / 60.0 * PI

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(rotation_speed * delta)
