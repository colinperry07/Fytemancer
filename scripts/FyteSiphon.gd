extends Node2D

export var flip_srite = false

var siphon_speed = 4
var shot_speed = 100

var siphoning = false

var siphonable_fytes = []
var fytes_in_siphon = []

onready var collection_area = $CollectionArea
onready var shot_point = $ShotPoint
onready var animated_sprite = $AnimatedSprite

func _physics_process(_delta):
	
	if flip_srite:
		animated_sprite.flip_v = true
	else:
		animated_sprite.flip_v = false
	
	look_at(get_global_mouse_position()) # makes the fytesiphon face the player mouse 
	
	if Input.is_action_pressed("SIPHON"):
		siphoning = true
		
		# sucks the fyte towards the CollectionArea Area2D
		if siphonable_fytes != []:
			for fyte in siphonable_fytes:
				fyte.being_siphoned = true
				var siphon_dir = (collection_area.global_position - fyte.global_position).normalized()
				fyte.global_position += siphon_dir * siphon_speed
	
	elif Input.is_action_just_released("SIPHON"):
		siphoning = false
		
		if siphonable_fytes != []:
			for fyte in siphonable_fytes:
				fyte.being_siphoned = false
	
	if Input.is_action_pressed("SHOOT"):
		
		if fytes_in_siphon != []:
			for fyte in fytes_in_siphon:
				
				fyte.global_position = shot_point.global_position
				fyte.siphoned = false
				
				# doesnt work :/
				var shot_dir = (shot_point.global_position - get_global_mouse_position()).normalized()
				fyte.velocity += shot_dir * shot_speed
				
				fytes_in_siphon.erase(fyte)
				yield(get_tree().create_timer(0.2), "timeout")


func _on_SiphoningCone_body_entered(body):
	if body.is_in_group('Fytes'):
		siphonable_fytes.append(body)


func _on_SiphoningCone_body_exited(body):
	if body in siphonable_fytes:
		body.being_siphoned = false
		siphonable_fytes.erase(body)


func _on_CollectionArea_body_entered(body):
	if body in siphonable_fytes and siphoning:
		fytes_in_siphon.append(body)
		body.siphoned = true
		body.being_siphoned = false
		siphonable_fytes.erase(body)
