extends Node2D


var siphon_speed = 4
var siphoning = false

var siphonable_fytes = []
var fytes_in_siphon = []

onready var collection_area = $CollectionArea

var previous_fyte_state = null

func _physics_process(_delta):
	
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
		siphonable_fytes.erase(body)
