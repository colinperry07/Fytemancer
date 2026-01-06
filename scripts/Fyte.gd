extends KinematicBody2D


const MAX_STAT_VALUE = 15

var stats = { # stat name -> id
	"attack": 0,
	"defense": 0,
	"stamina": 0
}

var hp # not sure how this is going to be calculated or come into play yet. but will be based heavily on stamina
var iv # individual value, calculates the fufillment of the random stats

var rating # this is the star rating of the Fyte
var catch_rate # this is the likelihood of catching the Fyte

var type # the type of fyte it is of type FyteType
var moveset = [] # this will be based on the type
var energy_produced # also based on the type

# enums for calculating different values
enum FyteType { PYRO, GEO, ELEKTRO, HYDRO, PETRA }

enum FyteRating { # the rating of the Fyte based on it's IV
	ZERO = 50,
	ONE = 65,
	TWO = 80,
	THREE = 100,
	FOUR = 101
} 

enum CatchDifficulty {
	GUARENTEED = 10,
	EASY = 25,
	MEDIUM = 50,
	HARD = 75,
	IMPOSSIBLE = 100
}


func _ready():
	randomize() # initializes random seed
	
	# distributes stats randomly
	var unallocated_points = randi() % 46 # picks a random amount of points between none and max stat points
	var keys = stats.keys() # gets the keys in the stats dict
	while unallocated_points > 0: # loops through and adds points to random stats for the total amount of points
		var key = keys[randi() % len(keys)]
		if stats[key]< MAX_STAT_VALUE:
			stats[key] += 1
			unallocated_points -= 1
	
	calculate_individual_value()
	calculate_catch_rate()


func calculate_individual_value():
	# calculates the total IV (Individual Value) of this Fyte
	var keys = stats.keys()
	var total = 0
	for key in keys:
		total += stats[key]
	iv = total/.45
	
	# iterates through the FyteRating enum values and finds the star rating for this specific Fyte
	for value in FyteRating.values():
		if iv < value:
			rating = FyteRating.find_key(value)
			break

func calculate_catch_rate(): # calculates catch rate based on the Fyte's stamina stat value
	var difficulty = stats['stamina']/.15
	for value in CatchDifficulty.values():
		if difficulty < value:
			catch_rate = CatchDifficulty.find_key(value)
			break

