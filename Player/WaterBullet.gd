extends Area2D


export var speed = 5

var direction = Vector2.ZERO
onready var animatedSprite = $AnimatedSprite
onready var collisionShape2D = $CollisionShape2D

func _physics_process(_delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		
		global_position += velocity

func set_direction(direction):
	self.direction = direction


func _on_WaterBullet_area_entered(area):
	if area.get_groups()[0] == "enemies":
		speed = 0
		animatedSprite.play("Splash")

func _on_AnimatedSprite_animation_finished():
	if animatedSprite.animation == "Splash":
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
