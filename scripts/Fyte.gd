extends KinematicBody2D


var catch_rate = 100
const MAX_CATCH_RATE = 100

var attack = 0
var defense = 0
var stamina = 0 # the higher this the higher hp
var iv # individual value, calculates the fufillment of the random stats

var type # the type of fyte it is, whether pyro or geo, etc...
var moveset = [] # this will be based on the type
var energy_produced # also based on the type


# 0 star < 50
# 1 star >= 50
# 2 star >= 75
# 3 star >= 90
# 4 star == 100

func _ready():
	randomize() # initializes random seed
	
	# distributes points across stats
	var unallocated = 45
	print(unallocated)
	for i in range(unallocated):
		var rng = randi()%3
		match rng:
			0:
				if attack >= 15 and defense >= 15:
					stamina += 1
				elif attack >= 15 and stamina >= 15:
					defense += 1
				else:
					attack += 1
			1:
				if defense >= 15 and attack >= 15:
					stamina += 1
				elif defense >= 15 and stamina >= 15:
					attack += 1
				else:
					defense += 1
			2:
				if stamina >= 15 and attack >= 15:
					defense += 1
				elif stamina >= 15 and defense >= 15:
					attack += 1
				else:
					stamina += 1
	
	print(attack, ' ', defense,' ', stamina)


func calculate_catch_rate(stats):
	pass
