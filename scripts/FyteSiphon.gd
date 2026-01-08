extends Node2D

var siphon_speed = 4
var siphoning = false

var body_in_cone = null
var fytes_in_siphon = []

onready var collection_area = $CollectionArea

var previous_fyte_state = null

func _physics_process(_delta):
	
	look_at(get_global_mouse_position()) # makes the fytesiphon face the player mouse 
	
	if Input.is_action_pressed("SIPHON"):
		siphoning = true
		# sucks the fyte towards the CollectionArea Area2D
		if body_in_cone != null:
			body_in_cone.being_siphoned = true
			var siphon_dir = (collection_area.global_position - body_in_cone.position).normalized()
			body_in_cone.position += siphon_dir * siphon_speed
	else:
		if body_in_cone != null:
			body_in_cone.being_siphoned = false
		siphoning = false
	
	print(fytes_in_siphon)

func _on_SiphoningCone_body_entered(body):
	if body.name == "Fyte" and body_in_cone == null:
		body_in_cone = body


func _on_SiphoningCone_body_exited(body):
	if body == body_in_cone:
		body_in_cone = null


func _on_CollectionArea_body_entered(body):
	if body == body_in_cone and siphoning:
		fytes_in_siphon.append(body_in_cone)
		body_in_cone.siphoned = true
		body_in_cone = null
