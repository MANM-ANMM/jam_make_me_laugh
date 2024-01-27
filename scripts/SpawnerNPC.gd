extends Node2D

class_name SpawnerNPC

@export var npc_scene : PackedScene
var positions_spawn:Array[Marker2D]
var positions_commisariats:Array[Marker2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	BusEvent.i_am_an_entrance.connect(add_position_spawn)
	BusEvent.i_am_a_commisariat.connect(func(c): positions_commisariats.push_back(c))

func add_position_spawn(m: Marker2D):
	positions_spawn.push_back(m)


func _on_timer_timeout():
	spawn_npc()

func spawn_npc():
	var npc : PNJ = npc_scene.instantiate()
	var indice_spawn = randi_range(0, positions_spawn.size()-1)
	npc.position = positions_spawn[indice_spawn].global_position
	indice_spawn = (indice_spawn + 1)%positions_spawn.size()
	npc.target_entrance = positions_spawn[indice_spawn]
	npc.commisariat = positions_commisariats.pick_random()
	add_sibling(npc)
