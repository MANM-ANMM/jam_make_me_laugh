extends Node2D

class_name SpawnerNPC

@export var npc_scene : PackedScene
var positions_spawn:Array[Marker2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	BusEvent.i_am_an_entrance.connect(add_position_spawn)

func add_position_spawn(m: Marker2D):
	positions_spawn.push_back(m)
	print(m.position)


func _on_timer_timeout():
	spawn_npc()

func spawn_npc():
	var npc : PNJ = npc_scene.instantiate()
	npc.position = positions_spawn.pick_random().position
	npc.target_entrance = positions_spawn.pick_random()
	add_sibling(npc)
