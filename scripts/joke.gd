extends Node2D

var profiles = ['Geek','Martin','Lilian']
var profile = null
var geek = ['GEEK_0', 'GEEK_1', 'GEEK_2', 'GEEK_3', 'GEEK_4', 'GEEK_5', 'GEEK_6', 'GEEK_7', 'GEEK_8', 'GEEK_9', 'GEEK_10', 'GEEK_11','GEEK_12','GEEK_13','GEEK_14']
var martin = ['MARTIN_0']
var lilian = ['LILIAN_0']
var joke = null

# Called when the node enters the scene tree for the first time.
func _ready():
	profiles.shuffle()
	profile=profile[0]
	
	match profile:
		'Geek':
			geek.shuffle()
			joke = geek[0]
		'Martin':
			martin.shuffle()
			joke = martin[0]
		'Lilian':
			lilian.shuffle()
			joke = lilian[0]
