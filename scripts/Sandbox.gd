extends Node2D

onready var fyte_scene = preload("res://scenes/Fyte.tscn")

var fyte_spawn_num = 2

func _ready():
	randomize()
	for _i in range(fyte_spawn_num): # temporary spawn algo
		var fyte_instance = fyte_scene.instance()
		fyte_instance.position = Vector2(randi()%1000, 100)
		add_child(fyte_instance)
