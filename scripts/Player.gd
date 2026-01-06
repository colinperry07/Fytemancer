extends KinematicBody2D

# movement variables
export var speed = 676
export var accel = 0.125
export var jump = 1000
export var GRAVITY = 75
export var MAX_FALL_SPEED = 3333
var velocity = Vector2.ZERO

func _physics_process(delta):
	
	# movement logic
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
		if velocity.y == MAX_FALL_SPEED:
			velocity.y = MAX_FALL_SPEED
		else:
			velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# next logc block here
