extends KinematicBody2D


var catch_rate = 100
const MAX_CATCH_RATE = 100

var stats = { # stat name -> id
	"attack": 0,
	"defense": 0,
	"stamina": 0
}

const MAX_STAT_VALUE = 15

var iv # individual value, calculates the fufillment of the random stats

enum FyteType { PYRO, GEO, ELEKTRO, HYDRO, PETRA}

var type # the type of fyte it is of type FyteType
var moveset = [] # this will be based on the type
var energy_produced # also based on the type


enum FyteRating {
	ZERO = 0,
	ONE = 50,
	TWO = 65,
	THREE = 80,
	FOUR = 100
}

func _ready():
	randomize() # initializes random seed
	
	# distributes stats randomly
	var unallocated_points = randi() % 46 # picks a random amount of points between none and max stat points
	var keys = stats.keys()
	while unallocated_points > 0:
		var key = keys[randi() % len(keys)]
		if stats[key]< MAX_STAT_VALUE:
			stats[key] += 1
			unallocated_points -= 1
	
	print(stats)


func calculate_catch_rate():
	pass
