extends KinematicBody2D

# movement variables
export var speed = 676
export var accel = 0.125
export var jump = 1000
const GRAVITY = 75
const MAX_FALL_SPEED = 1200
var velocity = Vector2.ZERO

# node variables
onready var fyte_siphon = $FyteSiphon


func _physics_process(_delta):
	
	movement_logic()


func movement_logic():
	
	var dir = 0
	if Input.is_action_pressed("LEFT"):
		dir -= 1
	if Input.is_action_pressed("RIGHT"):
		dir += 1

	if dir != 0:
		velocity.x = lerp(velocity.x, speed*dir, accel)
	else:
		velocity.x = lerp(velocity.x, 0, accel)
	
	if is_on_floor():
		velocity.y = 0
		if Input.is_action_pressed("JUMP"):
			velocity.y -= jump
	else:
		if velocity.y >= MAX_FALL_SPEED:
			velocity.y = MAX_FALL_SPEED
		else:
			velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, Vector2.UP)


