extends Marker2D


@export var policier_scene : PackedScene
var cop_parent:Node2D

func _ready():
	advertise_comisariat.call_deferred()

func advertise_comisariat():
	BusEvent.i_am_a_commisariat.emit(self)
	

func report_aggression():
	spawn_cop()

func spawn_cop():
	var cop = policier_scene.instantiate()
	cop.global_position = global_position
	cop_parent.add_child(cop)

func _on_timer_timeout():
	spawn_cop()
