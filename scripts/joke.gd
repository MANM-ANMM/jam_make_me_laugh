extends Node2D

var profiles = ['Geek', 'Martin', 'Lilian', 'Mamie', 'Enfant', 'Jogger']
var profile = null
var geek = ['GEEK_0', 'GEEK_1', 'GEEK_2', 'GEEK_3', 'GEEK_4', 'GEEK_5', 'GEEK_6', 'GEEK_7', 'GEEK_8', 'GEEK_9', 'GEEK_10', 'GEEK_11', 'GEEK_12', 'GEEK_13', 'GEEK_14', 'GEEK_15', 'GEEK_16']
var martin = ['MARTIN_0', 'MARTIN_1', 'MARTIN_2', 'MARTIN_3', 'MARTIN_4', 'MARTIN_5', 'MARTIN_6', 'MARTIN_7', 'MARTIN_8', 'MARTIN_9', 'MARTIN_10', 'MARTIN_11', 'MARTIN_12', 'MARTIN_13', 'MARTIN_14', 'MARTIN_15']
var lilian = ['LILIAN_0', 'LILIAN_1', 'LILIAN_2', 'LILIAN_3', 'LILIAN_4', 'LILIAN_5']
var mamie = ['MAMIE_0', 'MAMIE_1', 'MAMIE_2', 'MAMIE_3', 'MAMIE_4', 'MAMIE_5', 'MAMIE_6', 'MAMIE_7', 'MAMIE_8', 'MAMIE_9', 'MAMIE_10', 'MAMIE_11', 'MAMIE_12', 'MAMIE_13', 'MAMIE_14', 'MAMIE_15']
var enfant = ['ENFANT_0', 'ENFANT_1', 'ENFANT_2', 'ENFANT_3', 'ENFANT_4', 'ENFANT_5', 'ENFANT_6', 'ENFANT_7', 'ENFANT_8', 'ENFANT_9', 'ENFANT_10', 'ENFANT_11', 'ENFANT_12', 'ENFANT_13', 'ENFANT_14', 'ENFANT_15']
var jogger = ['JOGGER_0', 'JOGGER_1', 'JOGGER_2', 'JOGGER_3', 'JOGGER_4', 'JOGGER_5', 'JOGGER_6', 'JOGGER_7', 'JOGGER_8', 'JOGGER_9', 'JOGGER_10', 'JOGGER_11', 'JOGGER_12', 'JOGGER_13', 'JOGGER_14', 'JOGGER_15']
var joke = null

# Called when the node enters the scene tree for the first time.
func _ready():
	profiles.shuffle()
	profile=profiles[0]
	
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
		'Mamie':
			mamie.shuffle()
			joke = mamie[0]
		'Enfant':
			enfant.shuffle()
			joke = enfant[0]
		'Jogger':
			jogger.shuffle()
			joke = jogger[0]
