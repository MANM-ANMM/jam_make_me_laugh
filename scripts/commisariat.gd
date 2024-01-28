extends Marker2D


@export var policier_scene : PackedScene

func _ready():
	BusEvent.i_am_a_commisariat.emit(self)

func report_aggression():
	spawn_cop()

func spawn_cop():
	var cop = policier_scene.instantiate()
	cop.position = global_position
	add_sibling(cop)

func _on_timer_timeout():
	spawn_cop()
