extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500
const WATER_BULLET = preload("res://Player/WaterBullet.tscn")

var velocity = Vector2.ZERO

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var waterGun = $WaterGun

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	var mouse_position = get_local_mouse_position().normalized()
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	animationTree.set("parameters/Idle/blend_position", mouse_position)
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Run/blend_position", mouse_position)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
#	print(velocity)
#	print(mouse_position)
#	print(rad2deg(mouse_position.angle()))
	velocity = move_and_slide(velocity)
	gun_rotation(mouse_position)
	
	
	
func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		shoot_bullet()

func gun_rotation(mouse_position):
	waterGun.rotation_degrees = rad2deg(mouse_position.angle())
	if waterGun.rotation_degrees > 90 or waterGun.rotation_degrees < -90:
		waterGun.get_node("Sprite").flip_v = true
	else:
		waterGun.get_node("Sprite").flip_v = false

func shoot_bullet():
	var BulletInstance = WATER_BULLET.instance()
	self.get_parent().add_child(BulletInstance)
	BulletInstance.global_position = get_node("WaterGun/EndOfGun").global_position
	var target = get_global_mouse_position()
	var direction_to_mouse = BulletInstance.global_position.direction_to(target).normalized()
	BulletInstance.set_direction(direction_to_mouse)
	BulletInstance.rotation_degrees = rad2deg(direction_to_mouse.angle())
#	print(direction_to_mouse.angle())
	
	
