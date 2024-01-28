extends Node2D

var scene
var instance

@export var cop_parent:Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	scene = preload("res://scenes/dialog.tscn")
	BusEvent.dialog.connect(_on_dialog)
	BusEvent.end_dialog.connect(_on_end_dialog)
	Var.score = 0
	BusEvent.i_am_a_commisariat.connect(func(c): c.cop_parent = cop_parent)

func _on_dialog(_profile, _joke):
	$Level/Player/Camera2D.enabled = false
	$Level.get_tree().paused = true
	$Level.visible = false
	print($AudioStreamPlayer.get_volume_db())
	$AudioStreamPlayer.set_volume_db(-35)
	instance = scene.instantiate()
	instance.profile = _profile
	instance.joke = _joke
	instance.init()
	add_child(instance)
	
func _on_end_dialog():
	$Level/Player/Camera2D.enabled = true
	$Level.get_tree().paused = false
	$Level.visible = true
	$Level/Player.set_physics_process(false)
	$AudioStreamPlayer.set_volume_db(-27)
	get_tree().create_timer(0.5).timeout.connect(func():$Level/Player.set_physics_process(true))
