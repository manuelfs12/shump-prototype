extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

var velocity = Vector2.ZERO
onready var animatedSprite = $AnimatedSprite

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	var mouse_position = get_local_mouse_position()
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		if mouse_position.y < -20 and mouse_position.x > 0:
			animatedSprite.play("RunUpRight")
		elif mouse_position.y < -20 and mouse_position.x < 0:
			animatedSprite.play("RunUpLeft")
		elif mouse_position.x > 0:
			animatedSprite.play("RunRight")
		elif mouse_position.x < 0:
			animatedSprite.play("RunLeft")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
	else:
		if mouse_position.y < -20 and mouse_position.x > 0:
			animatedSprite.play("IdleUpRight")
		elif mouse_position.y < -20 and mouse_position.x < 0:
			animatedSprite.play("IdleUpLeft")
		elif mouse_position.x > 0:
			animatedSprite.play("IdleRight")
		elif mouse_position.x < 0:
			animatedSprite.play("IdleLeft")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
#	print(velocity)
	print(mouse_position)
	velocity = move_and_slide(velocity)
