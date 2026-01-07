extends Node2D

var body_in_cone

var fytes_in_siphon = []

func _physics_process(delta):
	look_at(get_global_mouse_position())


func _on_SiphoningCone_body_entered(body):
	if body.name == "Fyte":
		body_in_cone = body


func _on_SiphoningCone_body_exited(body):
	if body == body_in_cone:
		body_in_cone = null


func _on_CollectionArea_body_entered(body):
	pass # Replace with function body.
