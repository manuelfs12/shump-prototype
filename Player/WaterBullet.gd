extends Area2D


export var speed = 5

var direction = Vector2.ZERO

func _physics_process(_delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		
		global_position += velocity

func set_direction(direction):
	self.direction = direction
