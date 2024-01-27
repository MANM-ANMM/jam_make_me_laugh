extends Marker2D


@export var policier_scene : PackedScene

func _ready():
	BusEvent.i_am_a_commisariat.emit(self)

func report_aggression():
	var cop = policier_scene.instantiate()
	cop.position = global_position
	add_sibling(cop)
	
